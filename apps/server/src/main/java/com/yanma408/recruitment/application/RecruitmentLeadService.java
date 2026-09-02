package com.yanma408.recruitment.application;

import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Locale;
import java.util.Set;
import java.util.UUID;

@Service
public class RecruitmentLeadService {
    private static final Set<String> STUDY_STAGES = Set.of("NOT_STARTED", "FIRST_ROUND", "SECOND_ROUND", "REVIEWING");
    private static final Set<String> SUBJECTS = Set.of(
            "DATA_STRUCTURE", "COMPUTER_ORGANIZATION", "OPERATING_SYSTEM", "COMPUTER_NETWORK"
    );
    private static final int DEFAULT_PAGE_SIZE = 30;
    private static final int MAX_PAGE_SIZE = 100;

    private final NamedParameterJdbcTemplate jdbcTemplate;

    public RecruitmentLeadService(NamedParameterJdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Transactional
    public RecruitmentLeadView submit(
            String contactName,
            String wechatContact,
            int examYear,
            String targetSchool,
            String studyStage,
            List<String> weakSubjects,
            Integer weeklyHours,
            String currentConcern
    ) {
        var id = UUID.randomUUID();
        var now = LocalDateTime.now();
        var normalizedSubjects = normalizeSubjects(weakSubjects);
        jdbcTemplate.update("""
                INSERT INTO recruitment_leads (
                    id, contact_name, wechat_contact, exam_year, target_school,
                    study_stage, weak_subjects, weekly_hours, current_concern,
                    status, consented_at, created_at
                )
                VALUES (
                    :id, :contactName, :wechatContact, :examYear, :targetSchool,
                    :studyStage, :weakSubjects, :weeklyHours, :currentConcern,
                    'NEW', :now, :now
                )
                """, new MapSqlParameterSource()
                .addValue("id", id)
                .addValue("contactName", requireText(contactName, "contactName"))
                .addValue("wechatContact", requireText(wechatContact, "wechatContact"))
                .addValue("examYear", examYear)
                .addValue("targetSchool", blankToNull(targetSchool))
                .addValue("studyStage", normalizeStage(studyStage))
                .addValue("weakSubjects", String.join(",", normalizedSubjects))
                .addValue("weeklyHours", weeklyHours)
                .addValue("currentConcern", blankToNull(currentConcern))
                .addValue("now", now));
        return find(id);
    }

    public RecruitmentLeadPage list(int page, int size) {
        var normalizedPage = Math.max(0, page);
        var normalizedSize = normalizeSize(size);
        var total = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM recruitment_leads", new MapSqlParameterSource(), Integer.class);
        var items = jdbcTemplate.query("""
                SELECT id, contact_name, wechat_contact, exam_year, target_school,
                       study_stage, weak_subjects, weekly_hours, current_concern,
                       status, created_at
                FROM recruitment_leads
                ORDER BY created_at DESC
                LIMIT :limit OFFSET :offset
                """, new MapSqlParameterSource()
                .addValue("limit", normalizedSize)
                .addValue("offset", normalizedPage * normalizedSize), (rs, rowNum) -> toView(rs));
        var totalValue = total == null ? 0 : total;
        var totalPages = totalValue == 0 ? 0 : (int) Math.ceil((double) totalValue / normalizedSize);
        return new RecruitmentLeadPage(items, normalizedPage, normalizedSize, totalValue, totalPages);
    }

    private RecruitmentLeadView find(UUID id) {
        return jdbcTemplate.query("""
                SELECT id, contact_name, wechat_contact, exam_year, target_school,
                       study_stage, weak_subjects, weekly_hours, current_concern,
                       status, created_at
                FROM recruitment_leads
                WHERE id = :id
                """, new MapSqlParameterSource("id", id), (rs, rowNum) -> toView(rs))
                .stream()
                .findFirst()
                .orElseThrow(() -> new IllegalStateException("Recruitment lead was not persisted"));
    }

    private RecruitmentLeadView toView(ResultSet rs) throws SQLException {
        return new RecruitmentLeadView(
                rs.getObject("id", UUID.class),
                rs.getString("contact_name"),
                rs.getString("wechat_contact"),
                rs.getInt("exam_year"),
                rs.getString("target_school"),
                rs.getString("study_stage"),
                Arrays.stream(rs.getString("weak_subjects").split(","))
                        .filter(value -> !value.isBlank())
                        .toList(),
                (Integer) rs.getObject("weekly_hours"),
                rs.getString("current_concern"),
                rs.getString("status"),
                rs.getTimestamp("created_at").toLocalDateTime()
        );
    }

    private String normalizeStage(String value) {
        var normalized = requireText(value, "studyStage").toUpperCase(Locale.ROOT);
        if (!STUDY_STAGES.contains(normalized)) {
            throw new IllegalArgumentException("Unsupported studyStage: " + value);
        }
        return normalized;
    }

    private List<String> normalizeSubjects(List<String> values) {
        if (values == null || values.isEmpty()) {
            throw new IllegalArgumentException("weakSubjects is required");
        }
        var normalized = values.stream()
                .map(value -> requireText(value, "weakSubjects").toUpperCase(Locale.ROOT))
                .peek(value -> {
                    if (!SUBJECTS.contains(value)) {
                        throw new IllegalArgumentException("Unsupported weakSubjects value: " + value);
                    }
                })
                .collect(java.util.stream.Collectors.toCollection(LinkedHashSet::new));
        return List.copyOf(normalized);
    }

    private int normalizeSize(int size) {
        if (size <= 0) {
            return DEFAULT_PAGE_SIZE;
        }
        return Math.min(size, MAX_PAGE_SIZE);
    }

    private String requireText(String value, String fieldName) {
        if (value == null || value.isBlank()) {
            throw new IllegalArgumentException(fieldName + " is required");
        }
        return value.trim();
    }

    private String blankToNull(String value) {
        return value == null || value.isBlank() ? null : value.trim();
    }
}
