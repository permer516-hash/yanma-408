package com.yanma408.user.application.auth;

import com.yanma408.shared.exception.ResourceNotFoundException;
import com.yanma408.shared.application.security.UserRoleService;
import com.yanma408.user.domain.model.UserAccount;
import com.yanma408.user.domain.repository.AuthAuditRepository;
import com.yanma408.user.domain.repository.AuthTokenRepository;
import com.yanma408.user.domain.repository.UserAccountRepository;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.scheduling.annotation.Scheduled;

import java.time.Duration;
import java.time.Instant;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

@Service
public class AuthService {
    private static final Duration TOKEN_TTL = Duration.ofDays(30);
    private static final Duration PASSWORD_RESET_TTL = Duration.ofMinutes(30);
    private static final Duration LOGIN_WINDOW = Duration.ofMinutes(15);
    private static final Duration LOGIN_LOCK = Duration.ofMinutes(10);
    private static final int MAX_FAILED_LOGIN = 5;

    private final UserAccountRepository userAccountRepository;
    private final AuthTokenRepository authTokenRepository;
    private final AuthAuditRepository authAuditRepository;
    private final UserRoleService userRoleService;
    private final PasswordEncoder passwordEncoder;
    private final Map<String, LoginAttemptState> loginAttempts = new ConcurrentHashMap<>();

    public AuthService(
            UserAccountRepository userAccountRepository,
            AuthTokenRepository authTokenRepository,
            AuthAuditRepository authAuditRepository,
            UserRoleService userRoleService,
            PasswordEncoder passwordEncoder
    ) {
        this.userAccountRepository = userAccountRepository;
        this.authTokenRepository = authTokenRepository;
        this.authAuditRepository = authAuditRepository;
        this.userRoleService = userRoleService;
        this.passwordEncoder = passwordEncoder;
    }

    @Transactional
    public AuthResult register(RegisterCommand command) {
        assertPasswordStrength(command.password());
        var normalizedUsername = normalizeUsername(command.username());
        if (userAccountRepository.existsByUsername(normalizedUsername)) {
            throw new IllegalArgumentException("Username already exists");
        }
        var now = Instant.now();
        var user = new UserAccount(
                UUID.randomUUID(),
                normalizedUsername,
                command.displayName().trim(),
                passwordEncoder.encode(command.password()),
                now,
                now
        );
        userAccountRepository.save(user);
        userRoleService.grant(user.id(), "STUDENT");
        authAuditRepository.record(user.id(), user.username(), "REGISTER", true, null, null, "registered");
        return issueToken(user);
    }

    @Transactional
    public AuthResult login(LoginCommand command, String ipAddress, String userAgent) {
        var username = normalizeUsername(command.username());
        assertLoginAllowed(username, ipAddress, userAgent);
        var user = userAccountRepository.findByUsername(username)
                .orElseThrow(() -> {
                    recordFailedLogin(username, null, ipAddress, userAgent, "bad_credentials");
                    return new BadCredentialsException("Invalid username or password");
                });
        if (!passwordEncoder.matches(command.password(), user.passwordHash())) {
            recordFailedLogin(username, user.id(), ipAddress, userAgent, "bad_credentials");
            throw new BadCredentialsException("Invalid username or password");
        }
        loginAttempts.remove(username);
        authAuditRepository.record(user.id(), username, "LOGIN", true, ipAddress, userAgent, "login_success");
        return issueToken(user);
    }

    public CurrentUserView findCurrentUser(UUID userId) {
        var user = userAccountRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("User not found: " + userId));
        return new CurrentUserView(user.id(), user.username(), user.displayName(), userRoleService.roles(user.id()));
    }

    @Transactional
    public CurrentUserView createTeacher(RegisterCommand command, UUID createdBy) {
        assertPasswordStrength(command.password());
        var normalizedUsername = normalizeUsername(command.username());
        if (userAccountRepository.existsByUsername(normalizedUsername)) {
            throw new IllegalArgumentException("Username already exists");
        }
        var now = Instant.now();
        var user = new UserAccount(
                UUID.randomUUID(),
                normalizedUsername,
                command.displayName().trim(),
                passwordEncoder.encode(command.password()),
                now,
                now
        );
        userAccountRepository.save(user);
        userRoleService.grant(user.id(), "TEACHER");
        authAuditRepository.record(createdBy, normalizedUsername, "CREATE_TEACHER", true, null, null, "teacher_created");
        return new CurrentUserView(user.id(), user.username(), user.displayName(), userRoleService.roles(user.id()));
    }

    @Transactional
    public void logout(String authorizationHeader) {
        if (authorizationHeader == null || !authorizationHeader.startsWith("Bearer ")) {
            return;
        }
        authTokenRepository.revoke(authorizationHeader.substring("Bearer ".length()).trim());
    }

    @Transactional
    public PasswordResetRequestResult requestPasswordReset(String username, String ipAddress, String userAgent) {
        var user = userAccountRepository.findByUsername(normalizeUsername(username));
        if (user.isEmpty()) {
            authAuditRepository.record(null, normalizeUsername(username), "PASSWORD_RESET_REQUEST", true, ipAddress, userAgent, "unknown_user");
            return new PasswordResetRequestResult(true, null, null);
        }
        var token = UUID.randomUUID() + "." + UUID.randomUUID();
        var expiresAt = Instant.now().plus(PASSWORD_RESET_TTL);
        userAccountRepository.savePasswordResetToken(user.get().id(), com.yanma408.user.infrastructure.persistence.TokenHash.sha256(token), expiresAt);
        authAuditRepository.record(user.get().id(), user.get().username(), "PASSWORD_RESET_REQUEST", true, ipAddress, userAgent, "token_issued");
        return new PasswordResetRequestResult(true, token, expiresAt);
    }

    @Transactional
    public void confirmPasswordReset(String token, String newPassword, String ipAddress, String userAgent) {
        assertPasswordStrength(newPassword);
        var tokenHash = com.yanma408.user.infrastructure.persistence.TokenHash.sha256(token.trim());
        var user = userAccountRepository.findByPasswordResetTokenHash(tokenHash)
                .orElseThrow(() -> new IllegalArgumentException("Invalid or expired password reset token"));
        userAccountRepository.updatePassword(user.id(), passwordEncoder.encode(newPassword));
        authAuditRepository.record(user.id(), user.username(), "PASSWORD_RESET_CONFIRM", true, ipAddress, userAgent, "password_updated");
    }

    public List<AuthTokenView> findTokens(UUID userId) {
        return authTokenRepository.findByUser(userId);
    }

    @Transactional
    public void revokeToken(UUID userId, UUID tokenId) {
        authTokenRepository.revokeById(userId, tokenId);
        authAuditRepository.record(userId, null, "TOKEN_REVOKE", true, null, null, tokenId.toString());
    }

    public List<AuthAuditView> findAuditLogs(UUID userId, int limit) {
        return authAuditRepository.findByUser(userId, limit);
    }

    @Scheduled(initialDelay = 300_000L, fixedDelay = 3_600_000L)
    @Transactional
    public void cleanupExpiredTokens() {
        authTokenRepository.deleteExpired(Instant.now());
    }

    private AuthResult issueToken(UserAccount user) {
        var token = UUID.randomUUID() + "." + UUID.randomUUID();
        var expiresAt = Instant.now().plus(TOKEN_TTL);
        authTokenRepository.save(user.id(), token, expiresAt);
        return new AuthResult(user.id(), user.username(), user.displayName(), token, expiresAt);
    }

    private String normalizeUsername(String username) {
        return username.trim().toLowerCase();
    }

    private void assertPasswordStrength(String password) {
        if (password == null || password.length() < 8 || password.length() > 128) {
            throw new IllegalArgumentException("Password must be 8 to 128 characters");
        }
        var hasLetter = password.chars().anyMatch(Character::isLetter);
        var hasDigit = password.chars().anyMatch(Character::isDigit);
        if (!hasLetter || !hasDigit) {
            throw new IllegalArgumentException("Password must include letters and digits");
        }
    }

    private void assertLoginAllowed(String username, String ipAddress, String userAgent) {
        var state = loginAttempts.get(username);
        if (state == null) {
            return;
        }
        var now = Instant.now();
        if (state.lockedUntil() != null && state.lockedUntil().isAfter(now)) {
            authAuditRepository.record(null, username, "LOGIN_BLOCKED", false, ipAddress, userAgent, "rate_limited");
            throw new BadCredentialsException("Too many failed login attempts. Please try again later.");
        }
        if (state.firstFailedAt().plus(LOGIN_WINDOW).isBefore(now)) {
            loginAttempts.remove(username);
        }
    }

    private void recordFailedLogin(String username, UUID userId, String ipAddress, String userAgent, String details) {
        var now = Instant.now();
        loginAttempts.compute(username, (key, current) -> {
            var base = current == null || current.firstFailedAt().plus(LOGIN_WINDOW).isBefore(now)
                    ? new LoginAttemptState(0, now, null)
                    : current;
            var failedCount = base.failedCount() + 1;
            var lockedUntil = failedCount >= MAX_FAILED_LOGIN ? now.plus(LOGIN_LOCK) : null;
            return new LoginAttemptState(failedCount, base.firstFailedAt(), lockedUntil);
        });
        authAuditRepository.record(userId, username, "LOGIN", false, ipAddress, userAgent, details);
    }

    private record LoginAttemptState(int failedCount, Instant firstFailedAt, Instant lockedUntil) {
    }
}
