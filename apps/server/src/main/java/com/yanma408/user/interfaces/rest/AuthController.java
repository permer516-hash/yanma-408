package com.yanma408.user.interfaces.rest;

import com.yanma408.shared.application.security.CurrentUserProvider;
import com.yanma408.shared.application.security.UserRoleService;
import com.yanma408.user.application.auth.AuthAuditView;
import com.yanma408.user.application.auth.AuthResult;
import com.yanma408.user.application.auth.AuthService;
import com.yanma408.user.application.auth.AuthTokenView;
import com.yanma408.user.application.auth.CurrentUserView;
import com.yanma408.user.application.auth.LoginCommand;
import com.yanma408.user.application.auth.PasswordResetRequestResult;
import com.yanma408.user.application.auth.RegisterCommand;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/auth")
public class AuthController {
    private final AuthService authService;
    private final CurrentUserProvider currentUserProvider;
    private final UserRoleService userRoleService;

    public AuthController(AuthService authService, CurrentUserProvider currentUserProvider, UserRoleService userRoleService) {
        this.authService = authService;
        this.currentUserProvider = currentUserProvider;
        this.userRoleService = userRoleService;
    }

    @PostMapping("/register")
    public AuthResult register(@Valid @RequestBody RegisterRequest request, HttpServletRequest servletRequest) {
        return authService.register(
                new RegisterCommand(request.username(), request.displayName(), request.password()),
                clientIp(servletRequest),
                servletRequest.getHeader("User-Agent")
        );
    }

    @PostMapping("/login")
    public AuthResult login(@Valid @RequestBody LoginRequest request, HttpServletRequest servletRequest) {
        return authService.login(
                new LoginCommand(request.username(), request.password()),
                clientIp(servletRequest),
                servletRequest.getHeader("User-Agent")
        );
    }

    @PostMapping("/teachers")
    public CurrentUserView createTeacher(@Valid @RequestBody RegisterRequest request) {
        var userId = currentUserProvider.currentUserId();
        userRoleService.requireAny(userId, "ADMIN");
        return authService.createTeacher(new RegisterCommand(request.username(), request.displayName(), request.password()), userId);
    }

    @GetMapping("/me")
    public CurrentUserView me() {
        return authService.findCurrentUser(currentUserProvider.currentUserId());
    }

    @PostMapping("/logout")
    public void logout(@RequestHeader(value = "Authorization", required = false) String authorization) {
        authService.logout(authorization);
    }

    @PostMapping("/password-reset/request")
    public PasswordResetRequestResult requestPasswordReset(
            @Valid @RequestBody PasswordResetRequest request,
            HttpServletRequest servletRequest
    ) {
        userRoleService.requireAny(currentUserProvider.currentUserId(), "ADMIN");
        return authService.requestPasswordReset(
                request.username(),
                clientIp(servletRequest),
                servletRequest.getHeader("User-Agent")
        );
    }

    @PostMapping("/password-reset/confirm")
    public void confirmPasswordReset(
            @Valid @RequestBody ConfirmPasswordResetRequest request,
            HttpServletRequest servletRequest
    ) {
        authService.confirmPasswordReset(
                request.token(),
                request.newPassword(),
                clientIp(servletRequest),
                servletRequest.getHeader("User-Agent")
        );
    }

    @GetMapping("/tokens")
    public List<AuthTokenView> tokens() {
        return authService.findTokens(currentUserProvider.currentUserId());
    }

    @PatchMapping("/tokens/{id}/revoke")
    public void revokeToken(@PathVariable UUID id) {
        authService.revokeToken(currentUserProvider.currentUserId(), id);
    }

    @GetMapping("/audit-logs")
    public List<AuthAuditView> auditLogs(@RequestParam(defaultValue = "30") int limit) {
        return authService.findAuditLogs(currentUserProvider.currentUserId(), limit);
    }

    @GetMapping("/users")
    public List<com.yanma408.user.application.auth.UserSecurityView> users() {
        userRoleService.requireAny(currentUserProvider.currentUserId(), "ADMIN");
        return authService.findSecurityUsers();
    }

    @PatchMapping("/users/{id}/enabled")
    public com.yanma408.user.application.auth.UserSecurityView updateUserEnabled(
            @PathVariable UUID id,
            @Valid @RequestBody UpdateUserEnabledRequest request
    ) {
        var currentUserId = currentUserProvider.currentUserId();
        userRoleService.requireAny(currentUserId, "ADMIN");
        return authService.updateUserEnabled(id, request.enabled(), currentUserId);
    }

    public record RegisterRequest(
            @NotBlank @Size(min = 3, max = 64) String username,
            @NotBlank @Size(max = 64) String displayName,
            @NotBlank @Size(min = 6, max = 128) String password
    ) {
    }

    public record LoginRequest(
            @NotBlank String username,
            @NotBlank String password
    ) {
    }

    public record PasswordResetRequest(
            @NotBlank String username
    ) {
    }

    public record ConfirmPasswordResetRequest(
            @NotBlank String token,
            @NotBlank @Size(min = 8, max = 128) String newPassword
    ) {
    }

    public record UpdateUserEnabledRequest(boolean enabled) {
    }

    private String clientIp(HttpServletRequest request) {
        return request.getRemoteAddr();
    }
}
