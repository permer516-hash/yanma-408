package com.yanma408.workbench.application.content;

import com.yanma408.question.application.command.CreateQuestionCommand;
import com.yanma408.question.application.command.QuestionCommandService;
import com.yanma408.shared.exception.ResourceNotFoundException;
import com.yanma408.workbench.application.material.MaterialAsset;
import com.yanma408.workbench.application.material.MaterialAssetRepository;
import org.apache.pdfbox.Loader;
import org.apache.pdfbox.rendering.ImageType;
import org.apache.pdfbox.rendering.PDFRenderer;
import org.apache.pdfbox.text.PDFTextStripper;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import javax.imageio.ImageIO;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.ArrayList;
import java.util.HexFormat;
import java.util.HashMap;
import java.util.Map;
import java.util.List;
import java.util.Locale;
import java.util.Objects;
import java.util.Set;
import java.util.UUID;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

@Service
public class WorkbenchContentService {
    private static final Set<String> SOURCES = Set.of("PAST_EXAM", "MOCK", "ORIGINAL");
    private static final Set<String> DIFFICULTIES = Set.of("BASIC", "MEDIUM", "HARD");
    private static final Set<String> TYPES = Set.of("SINGLE_CHOICE", "MULTIPLE_CHOICE", "COMPREHENSIVE", "ALGORITHM", "CALCULATION");
    private static final Set<String> OBJECTIVE_TYPES = Set.of("SINGLE_CHOICE", "MULTIPLE_CHOICE");
    private static final Set<String> STEM_FORMATS = Set.of("PLAIN_TEXT", "MARKDOWN", "HTML", "IMAGE", "DIAGRAM");
    private static final double SIMILARITY_DUPLICATE_THRESHOLD = 0.82;
    private static final double SIMILARITY_WARNING_THRESHOLD = 0.62;

    private final NamedParameterJdbcTemplate jdbcTemplate;
    private final QuestionCommandService questionCommandService;
    private final MaterialAssetRepository materialAssetRepository;

    public WorkbenchContentService(
            NamedParameterJdbcTemplate jdbcTemplate,
            QuestionCommandService questionCommandService,
            MaterialAssetRepository materialAssetRepository
    ) {
        this.jdbcTemplate = jdbcTemplate;
        this.questionCommandService = questionCommandService;
        this.materialAssetRepository = materialAssetRepository;
    }

    public List<ContentQuotaView> listQuotas() {
        var sql = """
                SELECT quota.id, quota.subject_code, quota.chapter_code, quota.knowledge_point_code,
                       quota.source, quota.difficulty, quota.target_count, quota.priority, quota.notes,
                       (
                           SELECT COUNT(*)
                           FROM questions question
                           JOIN subjects subject ON subject.id = question.subject_id
                           JOIN chapters chapter ON chapter.id = question.chapter_id
                           JOIN question_knowledge_points relation ON relation.question_id = question.id
                           JOIN knowledge_points kp ON kp.id = relation.knowledge_point_id
                           WHERE question.status = 'PUBLISHED'
                             AND question.review_status = 'APPROVED'
                             AND subject.code = quota.subject_code
                             AND chapter.code = quota.chapter_code
                             AND kp.code = quota.knowledge_point_code
                             AND question.source = quota.source
                             AND question.difficulty = quota.difficulty
                       ) AS published_count,
                       (
                           SELECT COUNT(*)
                           FROM question_drafts draft
                           JOIN question_draft_knowledge_points draft_kp ON draft_kp.draft_id = draft.id
                           WHERE draft.status = 'APPROVED'
                             AND draft.review_status = 'APPROVED'
                             AND draft.subject_code = quota.subject_code
                             AND draft.chapter_code = quota.chapter_code
                             AND draft_kp.knowledge_point_code = quota.knowledge_point_code
                             AND draft.source = quota.source
                             AND draft.difficulty = quota.difficulty
                       ) AS approved_draft_count,
                       (
                           SELECT COUNT(*)
                           FROM question_drafts draft
                           JOIN question_draft_knowledge_points draft_kp ON draft_kp.draft_id = draft.id
                           WHERE draft.status = 'REVIEWING'
                             AND draft.subject_code = quota.subject_code
                             AND draft.chapter_code = quota.chapter_code
                             AND draft_kp.knowledge_point_code = quota.knowledge_point_code
                             AND draft.source = quota.source
                             AND draft.difficulty = quota.difficulty
                       ) AS reviewing_draft_count
                FROM question_content_quotas quota
                ORDER BY quota.subject_code, quota.knowledge_point_code, quota.source, quota.difficulty
                """;
        return jdbcTemplate.query(sql, new MapSqlParameterSource(), (rs, rowNum) -> {
            var target = rs.getInt("target_count");
            var published = rs.getInt("published_count");
            var approvedDraft = rs.getInt("approved_draft_count");
            var reviewingDraft = rs.getInt("reviewing_draft_count");
            return new ContentQuotaView(
                    rs.getObject("id", UUID.class),
                    rs.getString("subject_code"),
                    rs.getString("chapter_code"),
                    rs.getString("knowledge_point_code"),
                    rs.getString("source"),
                    rs.getString("difficulty"),
                    target,
                    published,
                    approvedDraft,
                    reviewingDraft,
                    Math.max(0, target - published - approvedDraft - reviewingDraft),
                    rs.getString("priority"),
                    rs.getString("notes")
            );
        });
    }

    @Transactional
    public QuestionDraftView createDraft(QuestionDraftCommand command) {
        var normalized = normalize(command);
        var createCommand = toQuestionCommand(normalized);
        var validation = questionCommandService.validateImport(List.of(createCommand));
        if (validation.invalidRows() > 0) {
            throw new IllegalArgumentException(validation.errors().get(0).message());
        }
        var id = UUID.randomUUID();
        var now = Instant.now();
        var fingerprint = fingerprint(normalized.stem(), normalized.options());
        jdbcTemplate.update("""
                INSERT INTO question_drafts (
                    id, material_asset_id, subject_code, chapter_code, type, difficulty, stem,
                    answer, explanation, source, source_year, score, stem_format, stem_image_url,
                    fingerprint, status, review_status, created_by, created_at, updated_at
                ) VALUES (
                    :id, :materialAssetId, :subjectCode, :chapterCode, :type, :difficulty, :stem,
                    :answer, :explanation, :source, :sourceYear, :score, :stemFormat, :stemImageUrl,
                    :fingerprint, 'DRAFT', 'PENDING', :createdBy, :createdAt, :updatedAt
                )
                """, draftParams(id, normalized, fingerprint, now));
        replaceDraftChildren(id, normalized);
        replaceDraftReferences(id, normalized);
        upsertTextVector("DRAFT", id, normalized.stem(), normalized.explanation());
        return getDraft(id);
    }

    public List<QuestionDraftView> listDrafts(String status, String reviewStatus) {
        var sql = new StringBuilder("""
                SELECT id FROM question_drafts
                WHERE 1 = 1
                """);
        var params = new MapSqlParameterSource();
        if (status != null && !status.isBlank()) {
            sql.append(" AND status = :status\n");
            params.addValue("status", status.trim().toUpperCase(Locale.ROOT));
        }
        if (reviewStatus != null && !reviewStatus.isBlank()) {
            sql.append(" AND review_status = :reviewStatus\n");
            params.addValue("reviewStatus", reviewStatus.trim().toUpperCase(Locale.ROOT));
        }
        sql.append(" ORDER BY updated_at DESC LIMIT 200");
        return jdbcTemplate.query(sql.toString(), params, (rs, rowNum) -> rs.getObject("id", UUID.class))
                .stream()
                .map(this::getDraft)
                .toList();
    }

    public QuestionDraftView getDraft(UUID id) {
        var rows = jdbcTemplate.query("""
                SELECT id, material_asset_id, subject_code, chapter_code, type, difficulty, stem,
                       answer, explanation, source, source_year, score, stem_format, stem_image_url,
                       fingerprint, status, review_status, review_note, published_question_id,
                       created_at, updated_at, reviewed_at, published_at
                FROM question_drafts
                WHERE id = :id
                """, new MapSqlParameterSource("id", id), this::mapDraft);
        return rows.stream().findFirst()
                .orElseThrow(() -> new ResourceNotFoundException("Question draft not found: " + id));
    }

    @Transactional
    public QuestionDraftView submitForReview(UUID id, String reviewerRole) {
        var role = normalizeReviewerRole(reviewerRole);
        var affected = jdbcTemplate.update("""
                UPDATE question_drafts
                SET status = 'REVIEWING',
                    review_status = 'PENDING',
                    updated_at = CURRENT_TIMESTAMP
                WHERE id = :id
                  AND status IN ('DRAFT', 'REJECTED')
                """, new MapSqlParameterSource("id", id));
        if (affected == 0) {
            throw new ResourceNotFoundException("Draft is not reviewable: " + id);
        }
        jdbcTemplate.update("""
                INSERT INTO question_draft_review_tasks (
                    id, draft_id, stage, status, reviewer_role, notes, created_at
                ) VALUES (
                    :taskId, :draftId, 'INITIAL_REVIEW', 'PENDING', :reviewerRole, null, CURRENT_TIMESTAMP
                )
                """, new MapSqlParameterSource()
                .addValue("taskId", UUID.randomUUID())
                .addValue("draftId", id)
                .addValue("reviewerRole", role));
        return getDraft(id);
    }

    @Transactional
    public QuestionDraftView review(UUID id, String reviewStatus, String note, String reviewerRole) {
        var normalizedReviewStatus = normalizeAllowed(reviewStatus, Set.of("APPROVED", "REJECTED"), "reviewStatus");
        var role = normalizeReviewerRole(reviewerRole);
        var status = "APPROVED".equals(normalizedReviewStatus) ? "APPROVED" : "REJECTED";
        var affected = jdbcTemplate.update("""
                UPDATE question_drafts
                SET status = :status,
                    review_status = :reviewStatus,
                    review_note = :reviewNote,
                    reviewed_by = :reviewedBy,
                    reviewed_at = CURRENT_TIMESTAMP,
                    updated_at = CURRENT_TIMESTAMP
                WHERE id = :id
                  AND status = 'REVIEWING'
                """, new MapSqlParameterSource()
                .addValue("id", id)
                .addValue("status", status)
                .addValue("reviewStatus", normalizedReviewStatus)
                .addValue("reviewNote", blankToNull(note))
                .addValue("reviewedBy", role));
        if (affected == 0) {
            throw new ResourceNotFoundException("Draft is not under review: " + id);
        }
        jdbcTemplate.update("""
                UPDATE question_draft_review_tasks
                SET status = :status,
                    notes = :notes,
                    completed_at = CURRENT_TIMESTAMP
                WHERE draft_id = :draftId
                  AND status = 'PENDING'
                """, new MapSqlParameterSource()
                .addValue("draftId", id)
                .addValue("status", normalizedReviewStatus)
                .addValue("notes", blankToNull(note)));
        if ("APPROVED".equals(normalizedReviewStatus)) {
            jdbcTemplate.update("""
                    INSERT INTO question_draft_review_tasks (
                        id, draft_id, stage, status, reviewer_role, notes, created_at
                    ) VALUES (
                        :taskId, :draftId, 'FINAL_REVIEW', 'APPROVED', :reviewerRole, :notes, CURRENT_TIMESTAMP
                    )
                    """, new MapSqlParameterSource()
                    .addValue("taskId", UUID.randomUUID())
                    .addValue("draftId", id)
                    .addValue("reviewerRole", role)
                    .addValue("notes", blankToNull(note)));
        }
        return getDraft(id);
    }

    @Transactional
    public QuestionDraftView publish(UUID id, String publisher) {
        var draft = getDraft(id);
        if (!"APPROVED".equals(draft.status()) || !"APPROVED".equals(draft.reviewStatus())) {
            throw new IllegalArgumentException("Only approved drafts can be published");
        }
        if (draft.publishedQuestionId() != null) {
            return draft;
        }
        var duplicates = checkDuplicates(id);
        var hasPublishedDuplicate = duplicates.items().stream()
                .anyMatch(item -> "QUESTION".equals(item.type()) && item.similarityScore() >= SIMILARITY_DUPLICATE_THRESHOLD);
        if (hasPublishedDuplicate) {
            throw new IllegalArgumentException("Published duplicate exists; resolve duplicate check before publishing");
        }
        var questionId = questionCommandService.create(toQuestionCommand(draft));
        upsertTextVector("QUESTION", questionId, draft.stem(), draft.explanation());
        jdbcTemplate.update("""
                UPDATE question_drafts
                SET status = 'PUBLISHED',
                    published_question_id = :questionId,
                    published_by = :publishedBy,
                    published_at = CURRENT_TIMESTAMP,
                    updated_at = CURRENT_TIMESTAMP
                WHERE id = :id
                """, new MapSqlParameterSource()
                .addValue("id", id)
                .addValue("questionId", questionId)
                .addValue("publishedBy", blankToNull(publisher)));
        return getDraft(id);
    }

    public DuplicateCheckResult checkDuplicates(UUID id) {
        var draft = getDraft(id);
        var items = new ArrayList<DuplicateCheckResult.DuplicateItem>();
        var draftVector = tokenVector(draft.stem() + " " + draft.explanation());
        jdbcTemplate.query("""
                SELECT id, status, stem
                FROM question_drafts
                WHERE id <> :id
                ORDER BY updated_at DESC
                """, new MapSqlParameterSource()
                .addValue("id", id), rs -> {
            var stem = rs.getString("stem");
            var fingerprintMatched = fingerprint(stem, List.of()).equals(draft.fingerprint());
            var similarity = cosineSimilarity(draftVector, tokenVector(stem));
            if (fingerprintMatched || similarity >= SIMILARITY_WARNING_THRESHOLD) {
                items.add(new DuplicateCheckResult.DuplicateItem(
                        "DRAFT",
                        rs.getObject("id", UUID.class),
                        rs.getString("status"),
                        preview(stem),
                        fingerprintMatched ? "FINGERPRINT" : "TOKEN_VECTOR",
                        fingerprintMatched ? 1.0 : roundSimilarity(similarity)
                ));
            }
        });
        jdbcTemplate.query("""
                SELECT id, status, stem, explanation
                FROM questions
                WHERE status <> 'DELETED'
                """, new MapSqlParameterSource(), rs -> {
            var stem = rs.getString("stem");
            var questionFingerprint = fingerprint(stem, List.of());
            var fingerprintMatched = questionFingerprint.equals(draft.fingerprint());
            var similarity = cosineSimilarity(draftVector, tokenVector(stem + " " + rs.getString("explanation")));
            if (fingerprintMatched || similarity >= SIMILARITY_WARNING_THRESHOLD) {
                items.add(new DuplicateCheckResult.DuplicateItem(
                        "QUESTION",
                        rs.getObject("id", UUID.class),
                        rs.getString("status"),
                        preview(stem),
                        fingerprintMatched ? "FINGERPRINT" : "TOKEN_VECTOR",
                        fingerprintMatched ? 1.0 : roundSimilarity(similarity)
                ));
            }
        });
        return new DuplicateCheckResult(
                id,
                draft.fingerprint(),
                items.stream().anyMatch(item -> item.similarityScore() >= SIMILARITY_DUPLICATE_THRESHOLD),
                items
        );
    }

    @Transactional
    public List<MaterialExtractionCandidate> extractCandidates(UUID materialAssetId, int startPage, int endPage, UUID createdBy) {
        if (startPage <= 0 || endPage < startPage || endPage - startPage > 20) {
            throw new IllegalArgumentException("page range must be positive and contain at most 21 pages");
        }
        var asset = materialAssetRepository.findById(materialAssetId)
                .orElseThrow(() -> new ResourceNotFoundException("Material asset not found: " + materialAssetId));
        if (!asset.originalFileName().toLowerCase(Locale.ROOT).endsWith(".pdf")) {
            throw new IllegalArgumentException("Only PDF material extraction is supported");
        }
        if (!"LOCAL".equals(asset.bucket())) {
            throw new IllegalArgumentException("PDF extraction currently requires a local scanned material asset");
        }
        var path = Path.of(asset.objectKey());
        if (!Files.isRegularFile(path)) {
            throw new IllegalArgumentException("Local material file is not readable");
        }
        var candidates = new ArrayList<MaterialExtractionCandidate>();
        try (var document = Loader.loadPDF(path.toFile())) {
            var pageCount = document.getNumberOfPages();
            var normalizedEnd = Math.min(endPage, pageCount);
            var stripper = new PDFTextStripper();
            for (int page = startPage; page <= normalizedEnd; page++) {
                stripper.setStartPage(page);
                stripper.setEndPage(page);
                var text = normalizeExtractedText(stripper.getText(document));
                var method = text.isBlank() ? "OCR" : "PDF_TEXT";
                var status = text.isBlank() ? "OCR_REQUIRED" : "EXTRACTED";
                var candidate = saveExtractionCandidate(
                        asset,
                        page,
                        method,
                        status,
                        text.isBlank() ? null : text,
                        text.isBlank() ? null : suggestStem(text),
                        text.isBlank() ? BigDecimal.valueOf(0.20) : BigDecimal.valueOf(0.85),
                        createdBy
                );
                candidates.add(candidate);
            }
        } catch (IOException exception) {
            throw new IllegalArgumentException("Failed to extract PDF text: " + exception.getMessage());
        }
        return candidates;
    }

    public List<MaterialExtractionCandidate> listCandidates(UUID materialAssetId) {
        return jdbcTemplate.query("""
                SELECT id, material_asset_id, page_number, extraction_method, status,
                       raw_text, suggested_stem, ocr_text, corrected_stem, corrected_answer,
                       corrected_explanation, corrected_options, corrected_question_type,
                       failure_reason, confidence, created_at
                FROM material_extraction_candidates
                WHERE material_asset_id = :materialAssetId
                ORDER BY page_number, created_at
                """, new MapSqlParameterSource("materialAssetId", materialAssetId), this::mapCandidate);
    }

    @Transactional
    public MaterialExtractionCandidate runOcr(UUID candidateId, String ocrTextOverride, UUID userId) {
        var candidate = getCandidate(candidateId);
        var text = blankToNull(ocrTextOverride);
        String failureReason = null;
        if (text == null) {
            try {
                text = runLocalTesseract(candidate);
            } catch (RuntimeException exception) {
                failureReason = exception.getMessage();
            }
        }
        if (text == null || text.isBlank()) {
            jdbcTemplate.update("""
                    UPDATE material_extraction_candidates
                    SET status = 'FAILED',
                        failure_reason = :failureReason,
                        reviewed_by = :reviewedBy,
                        reviewed_at = CURRENT_TIMESTAMP
                    WHERE id = :id
                    """, new MapSqlParameterSource()
                    .addValue("id", candidateId)
                    .addValue("failureReason", failureReason == null ? "OCR produced no text" : failureReason)
                    .addValue("reviewedBy", userId));
            return getCandidate(candidateId);
        }
        var normalized = normalizeExtractedText(text);
        jdbcTemplate.update("""
                UPDATE material_extraction_candidates
                SET status = 'OCR_DONE',
                    ocr_text = :ocrText,
                    raw_text = COALESCE(raw_text, :ocrText),
                    suggested_stem = :suggestedStem,
                    confidence = :confidence,
                    failure_reason = null,
                    reviewed_by = :reviewedBy,
                    reviewed_at = CURRENT_TIMESTAMP
                WHERE id = :id
                """, new MapSqlParameterSource()
                .addValue("id", candidateId)
                .addValue("ocrText", normalized)
                .addValue("suggestedStem", suggestStem(normalized))
                .addValue("confidence", BigDecimal.valueOf(0.72))
                .addValue("reviewedBy", userId));
        return getCandidate(candidateId);
    }

    @Transactional
    public MaterialExtractionCandidate reviewCandidate(UUID candidateId, CandidateReviewCommand command, UUID userId) {
        requireText(command.stem(), "stem");
        requireText(command.answer(), "answer");
        requireText(command.explanation(), "explanation");
        var type = command.type() == null || command.type().isBlank()
                ? "SINGLE_CHOICE"
                : normalizeQuestionType(command.type());
        var options = command.options() == null ? List.<QuestionDraftCommand.OptionCommand>of() : command.options();
        if (OBJECTIVE_TYPES.contains(type) && options.size() < 2) {
            throw new IllegalArgumentException("At least two options are required for objective candidates");
        }
        jdbcTemplate.update("""
                UPDATE material_extraction_candidates
                SET status = 'REVIEWED',
                    corrected_stem = :stem,
                    corrected_answer = :answer,
                    corrected_explanation = :explanation,
                    corrected_options = :options,
                    corrected_question_type = :type,
                    reviewed_by = :reviewedBy,
                    reviewed_at = CURRENT_TIMESTAMP
                WHERE id = :id
                """, new MapSqlParameterSource()
                .addValue("id", candidateId)
                .addValue("stem", command.stem().trim())
                .addValue("answer", command.answer().trim())
                .addValue("explanation", command.explanation().trim())
                .addValue("options", encodeOptions(options))
                .addValue("type", type)
                .addValue("reviewedBy", userId));
        return getCandidate(candidateId);
    }

    @Transactional
    public CandidateDraftBatchResult createDraftsFromCandidates(
            List<UUID> candidateIds,
            CandidateDraftDefaults defaults,
            UUID userId
    ) {
        if (candidateIds == null || candidateIds.isEmpty()) {
            throw new IllegalArgumentException("candidateIds is required");
        }
        var created = new ArrayList<CandidateDraftBatchResult.CreatedDraft>();
        for (UUID candidateId : candidateIds) {
            var candidate = getCandidate(candidateId);
            var command = draftCommandFromCandidate(candidate, defaults, userId);
            var draft = createDraft(command);
            jdbcTemplate.update("""
                    UPDATE material_extraction_candidates
                    SET status = 'DRAFTED',
                        reviewed_by = :reviewedBy,
                        reviewed_at = CURRENT_TIMESTAMP
                    WHERE id = :id
                    """, new MapSqlParameterSource()
                    .addValue("id", candidateId)
                    .addValue("reviewedBy", userId));
            created.add(new CandidateDraftBatchResult.CreatedDraft(candidateId, draft.id()));
        }
        return new CandidateDraftBatchResult(candidateIds.size(), created.size(), created);
    }

    private QuestionDraftCommand normalize(QuestionDraftCommand command) {
        requireText(command.subjectCode(), "subjectCode");
        requireText(command.chapterCode(), "chapterCode");
        requireText(command.type(), "type");
        requireText(command.difficulty(), "difficulty");
        requireText(command.stem(), "stem");
        requireText(command.answer(), "answer");
        requireText(command.explanation(), "explanation");
        requireText(command.source(), "source");
        if (command.knowledgePointCodes() == null || command.knowledgePointCodes().isEmpty()) {
            throw new IllegalArgumentException("At least one knowledge point is required");
        }
        var type = normalizeQuestionType(command.type());
        var options = command.options() == null ? List.<QuestionDraftCommand.OptionCommand>of() : command.options();
        if (OBJECTIVE_TYPES.contains(type) && options.size() < 2) {
            throw new IllegalArgumentException("At least two options are required for objective questions");
        }
        var difficulty = normalizeAllowed(command.difficulty(), DIFFICULTIES, "difficulty");
        var source = normalizeSource(command.source());
        if ("PAST_EXAM".equals(source)) {
            throw new IllegalArgumentException("Past exam drafts require copyright audit before direct creation");
        }
        if (command.sourceYear() != null && (command.sourceYear() < 2009 || command.sourceYear() > 2100)) {
            throw new IllegalArgumentException("sourceYear must be between 2009 and 2100");
        }
        var stemFormat = command.stemFormat() == null || command.stemFormat().isBlank()
                ? "PLAIN_TEXT"
                : normalizeAllowed(command.stemFormat(), STEM_FORMATS, "stemFormat");
        return new QuestionDraftCommand(
                command.materialAssetId(),
                command.subjectCode().trim().toUpperCase(Locale.ROOT),
                command.chapterCode().trim().toUpperCase(Locale.ROOT),
                type,
                difficulty,
                command.stem().trim(),
                command.answer().trim().toUpperCase(Locale.ROOT),
                command.explanation().trim(),
                source,
                command.sourceYear(),
                command.score() == null ? BigDecimal.valueOf(2) : command.score(),
                stemFormat,
                blankToNull(command.stemImageUrl()),
                options.stream()
                        .map(option -> new QuestionDraftCommand.OptionCommand(
                                normalizeOptionLabel(option.label()),
                                text(option.content(), "option.content")
                        ))
                        .toList(),
                command.knowledgePointCodes().stream()
                        .map(code -> text(code, "knowledgePointCodes").toUpperCase(Locale.ROOT))
                        .distinct()
                        .toList(),
                command.tags() == null ? List.of() : command.tags().stream()
                        .map(this::blankToNull)
                        .filter(tag -> tag != null && !tag.isBlank())
                        .distinct()
                        .toList(),
                command.pageReferences() == null ? List.of() : command.pageReferences().stream()
                        .filter(reference -> reference != null)
                        .map(reference -> new QuestionDraftCommand.PageReferenceCommand(
                                reference.materialAssetId(),
                                reference.extractionCandidateId(),
                                reference.pageNumber(),
                                blankToNull(reference.quote()),
                                blankToNull(reference.referenceNote())
                        ))
                        .toList(),
                blankToNull(command.createdBy())
        );
    }

    private CreateQuestionCommand toQuestionCommand(QuestionDraftCommand command) {
        return new CreateQuestionCommand(
                command.subjectCode(),
                command.chapterCode(),
                command.type(),
                command.difficulty(),
                command.stem(),
                command.answer(),
                command.explanation(),
                command.source(),
                command.sourceYear(),
                command.score(),
                command.stemFormat(),
                command.stemImageUrl(),
                command.options().stream()
                        .map(option -> new CreateQuestionCommand.OptionCommand(option.label(), option.content()))
                        .toList(),
                command.knowledgePointCodes(),
                command.tags()
        );
    }

    private CreateQuestionCommand toQuestionCommand(QuestionDraftView draft) {
        return new CreateQuestionCommand(
                draft.subjectCode(),
                draft.chapterCode(),
                draft.type(),
                draft.difficulty(),
                draft.stem(),
                draft.answer(),
                draft.explanation(),
                draft.source(),
                draft.sourceYear(),
                draft.score(),
                draft.stemFormat(),
                draft.stemImageUrl(),
                draft.options().stream()
                        .map(option -> new CreateQuestionCommand.OptionCommand(option.label(), option.content()))
                        .toList(),
                draft.knowledgePointCodes(),
                draft.tags()
        );
    }

    private MapSqlParameterSource draftParams(UUID id, QuestionDraftCommand command, String fingerprint, Instant now) {
        return new MapSqlParameterSource()
                .addValue("id", id)
                .addValue("materialAssetId", command.materialAssetId())
                .addValue("subjectCode", command.subjectCode())
                .addValue("chapterCode", command.chapterCode())
                .addValue("type", command.type())
                .addValue("difficulty", command.difficulty())
                .addValue("stem", command.stem())
                .addValue("answer", command.answer())
                .addValue("explanation", command.explanation())
                .addValue("source", command.source())
                .addValue("sourceYear", command.sourceYear())
                .addValue("score", command.score())
                .addValue("stemFormat", command.stemFormat())
                .addValue("stemImageUrl", command.stemImageUrl())
                .addValue("fingerprint", fingerprint)
                .addValue("createdBy", command.createdBy())
                .addValue("createdAt", Timestamp.from(now))
                .addValue("updatedAt", Timestamp.from(now));
    }

    private void replaceDraftChildren(UUID id, QuestionDraftCommand command) {
        for (int index = 0; index < command.options().size(); index++) {
            var option = command.options().get(index);
            jdbcTemplate.update("""
                    INSERT INTO question_draft_options (id, draft_id, label, content, sort_order)
                    VALUES (:id, :draftId, :label, :content, :sortOrder)
                    """, new MapSqlParameterSource()
                    .addValue("id", UUID.randomUUID())
                    .addValue("draftId", id)
                    .addValue("label", option.label())
                    .addValue("content", option.content())
                    .addValue("sortOrder", index + 1));
        }
        for (String code : command.knowledgePointCodes()) {
            jdbcTemplate.update("""
                    INSERT INTO question_draft_knowledge_points (draft_id, knowledge_point_code)
                    VALUES (:draftId, :code)
                    """, new MapSqlParameterSource()
                    .addValue("draftId", id)
                    .addValue("code", code));
        }
        for (String tag : command.tags()) {
            jdbcTemplate.update("""
                    INSERT INTO question_draft_tags (draft_id, tag)
                    VALUES (:draftId, :tag)
                    """, new MapSqlParameterSource()
                    .addValue("draftId", id)
                    .addValue("tag", tag));
        }
    }

    private QuestionDraftView mapDraft(ResultSet rs, int rowNum) throws SQLException {
        var id = rs.getObject("id", UUID.class);
        return new QuestionDraftView(
                id,
                rs.getObject("material_asset_id", UUID.class),
                rs.getString("subject_code"),
                rs.getString("chapter_code"),
                rs.getString("type"),
                rs.getString("difficulty"),
                rs.getString("stem"),
                rs.getString("answer"),
                rs.getString("explanation"),
                rs.getString("source"),
                nullableInteger(rs, "source_year"),
                rs.getBigDecimal("score"),
                rs.getString("stem_format"),
                rs.getString("stem_image_url"),
                rs.getString("fingerprint"),
                rs.getString("status"),
                rs.getString("review_status"),
                rs.getString("review_note"),
                rs.getObject("published_question_id", UUID.class),
                draftOptions(id),
                draftKnowledgePoints(id),
                draftTags(id),
                draftReferences(id),
                rs.getTimestamp("created_at").toInstant(),
                rs.getTimestamp("updated_at").toInstant(),
                nullableInstant(rs, "reviewed_at"),
                nullableInstant(rs, "published_at")
        );
    }

    private List<QuestionDraftView.OptionView> draftOptions(UUID id) {
        return jdbcTemplate.query("""
                SELECT label, content
                FROM question_draft_options
                WHERE draft_id = :id
                ORDER BY sort_order
                """, new MapSqlParameterSource("id", id),
                (rs, rowNum) -> new QuestionDraftView.OptionView(rs.getString("label"), rs.getString("content")));
    }

    private List<String> draftKnowledgePoints(UUID id) {
        return jdbcTemplate.queryForList("""
                SELECT knowledge_point_code
                FROM question_draft_knowledge_points
                WHERE draft_id = :id
                ORDER BY knowledge_point_code
                """, new MapSqlParameterSource("id", id), String.class);
    }

    private List<String> draftTags(UUID id) {
        return jdbcTemplate.queryForList("""
                SELECT tag
                FROM question_draft_tags
                WHERE draft_id = :id
                ORDER BY tag
                """, new MapSqlParameterSource("id", id), String.class);
    }

    private List<QuestionDraftView.PageReferenceView> draftReferences(UUID id) {
        return jdbcTemplate.query("""
                SELECT id, material_asset_id, extraction_candidate_id, page_number, quote, reference_note
                FROM question_draft_references
                WHERE draft_id = :id
                ORDER BY page_number, created_at
                """, new MapSqlParameterSource("id", id),
                (rs, rowNum) -> new QuestionDraftView.PageReferenceView(
                        rs.getObject("id", UUID.class),
                        rs.getObject("material_asset_id", UUID.class),
                        rs.getObject("extraction_candidate_id", UUID.class),
                        nullableInteger(rs, "page_number"),
                        rs.getString("quote"),
                        rs.getString("reference_note")
                ));
    }

    private void replaceDraftReferences(UUID id, QuestionDraftCommand command) {
        for (QuestionDraftCommand.PageReferenceCommand reference : command.pageReferences()) {
            if (reference.pageNumber() != null && reference.pageNumber() <= 0) {
                throw new IllegalArgumentException("pageNumber must be positive");
            }
            jdbcTemplate.update("""
                    INSERT INTO question_draft_references (
                        id, draft_id, material_asset_id, extraction_candidate_id,
                        page_number, quote, reference_note, created_at
                    ) VALUES (
                        :id, :draftId, :materialAssetId, :extractionCandidateId,
                        :pageNumber, :quote, :referenceNote, CURRENT_TIMESTAMP
                    )
                    """, new MapSqlParameterSource()
                    .addValue("id", UUID.randomUUID())
                    .addValue("draftId", id)
                    .addValue("materialAssetId", reference.materialAssetId())
                    .addValue("extractionCandidateId", reference.extractionCandidateId())
                    .addValue("pageNumber", reference.pageNumber())
                    .addValue("quote", reference.quote())
                    .addValue("referenceNote", reference.referenceNote()));
        }
    }

    private MaterialExtractionCandidate saveExtractionCandidate(
            MaterialAsset asset,
            int page,
            String method,
            String status,
            String rawText,
            String suggestedStem,
            BigDecimal confidence,
            UUID createdBy
    ) {
        var id = UUID.randomUUID();
        jdbcTemplate.update("""
                INSERT INTO material_extraction_candidates (
                    id, material_asset_id, page_number, extraction_method, status,
                    raw_text, suggested_stem, confidence, created_by, created_at
                ) VALUES (
                    :id, :materialAssetId, :pageNumber, :extractionMethod, :status,
                    :rawText, :suggestedStem, :confidence, :createdBy, CURRENT_TIMESTAMP
                )
                """, new MapSqlParameterSource()
                .addValue("id", id)
                .addValue("materialAssetId", asset.id())
                .addValue("pageNumber", page)
                .addValue("extractionMethod", method)
                .addValue("status", status)
                .addValue("rawText", rawText)
                .addValue("suggestedStem", suggestedStem)
                .addValue("confidence", confidence)
                .addValue("createdBy", createdBy));
        return new MaterialExtractionCandidate(
                id,
                asset.id(),
                page,
                method,
                status,
                rawText,
                suggestedStem,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                confidence.doubleValue(),
                Instant.now()
        );
    }

    private MaterialExtractionCandidate getCandidate(UUID id) {
        return jdbcTemplate.query("""
                SELECT id, material_asset_id, page_number, extraction_method, status,
                       raw_text, suggested_stem, ocr_text, corrected_stem, corrected_answer,
                       corrected_explanation, corrected_options, corrected_question_type,
                       failure_reason, confidence, created_at
                FROM material_extraction_candidates
                WHERE id = :id
                """, new MapSqlParameterSource("id", id), this::mapCandidate)
                .stream()
                .findFirst()
                .orElseThrow(() -> new ResourceNotFoundException("Extraction candidate not found: " + id));
    }

    private MaterialExtractionCandidate mapCandidate(ResultSet rs, int rowNum) throws SQLException {
        var confidence = rs.getBigDecimal("confidence");
        return new MaterialExtractionCandidate(
                rs.getObject("id", UUID.class),
                rs.getObject("material_asset_id", UUID.class),
                rs.getInt("page_number"),
                rs.getString("extraction_method"),
                rs.getString("status"),
                rs.getString("raw_text"),
                rs.getString("suggested_stem"),
                rs.getString("ocr_text"),
                rs.getString("corrected_stem"),
                rs.getString("corrected_answer"),
                rs.getString("corrected_explanation"),
                rs.getString("corrected_options"),
                rs.getString("corrected_question_type"),
                rs.getString("failure_reason"),
                confidence == null ? 0.0 : confidence.doubleValue(),
                rs.getTimestamp("created_at").toInstant()
        );
    }

    private String runLocalTesseract(MaterialExtractionCandidate candidate) {
        var asset = materialAssetRepository.findById(candidate.materialAssetId())
                .orElseThrow(() -> new ResourceNotFoundException("Material asset not found: " + candidate.materialAssetId()));
        if (!"LOCAL".equals(asset.bucket())) {
            throw new IllegalArgumentException("OCR currently requires a local scanned material asset");
        }
        if (!commandExists("tesseract")) {
            throw new IllegalArgumentException("Local OCR command tesseract is not installed");
        }
        var path = Path.of(asset.objectKey());
        try (var document = Loader.loadPDF(path.toFile())) {
            if (candidate.pageNumber() > document.getNumberOfPages()) {
                throw new IllegalArgumentException("candidate page is outside PDF page range");
            }
            var renderer = new PDFRenderer(document);
            var image = renderer.renderImageWithDPI(candidate.pageNumber() - 1, 220, ImageType.RGB);
            var imagePath = Files.createTempFile("yanma408-ocr-", ".png");
            try {
                ImageIO.write(image, "png", imagePath.toFile());
                var process = new ProcessBuilder("tesseract", imagePath.toString(), "stdout", "-l", "chi_sim+eng")
                        .redirectErrorStream(true)
                        .start();
                var output = new StringBuilder();
                try (var reader = new BufferedReader(new InputStreamReader(process.getInputStream(), StandardCharsets.UTF_8))) {
                    String line;
                    while ((line = reader.readLine()) != null) {
                        output.append(line).append('\n');
                    }
                }
                if (!process.waitFor(30, TimeUnit.SECONDS)) {
                    process.destroyForcibly();
                    throw new IllegalArgumentException("OCR timed out after 30 seconds");
                }
                if (process.exitValue() != 0) {
                    throw new IllegalArgumentException("OCR failed: " + output.toString().trim());
                }
                return normalizeExtractedText(output.toString());
            } finally {
                Files.deleteIfExists(imagePath);
            }
        } catch (IOException exception) {
            throw new IllegalArgumentException("Failed to run OCR: " + exception.getMessage());
        } catch (InterruptedException exception) {
            Thread.currentThread().interrupt();
            throw new IllegalArgumentException("OCR was interrupted");
        }
    }

    private boolean commandExists(String command) {
        try {
            var process = new ProcessBuilder("sh", "-c", "command -v " + command)
                    .redirectErrorStream(true)
                    .start();
            return process.waitFor(5, TimeUnit.SECONDS) && process.exitValue() == 0;
        } catch (IOException | InterruptedException exception) {
            if (exception instanceof InterruptedException) {
                Thread.currentThread().interrupt();
            }
            return false;
        }
    }

    private QuestionDraftCommand draftCommandFromCandidate(
            MaterialExtractionCandidate candidate,
            CandidateDraftDefaults defaults,
            UUID userId
    ) {
        var type = candidate.correctedQuestionType() == null || candidate.correctedQuestionType().isBlank()
                ? "COMPREHENSIVE"
                : candidate.correctedQuestionType();
        var stem = firstNonBlank(candidate.correctedStem(), candidate.suggestedStem(), candidate.ocrText(), candidate.rawText());
        if (stem == null) {
            throw new IllegalArgumentException("Candidate has no reviewed stem: " + candidate.id());
        }
        var answer = firstNonBlank(candidate.correctedAnswer(), "参考答案见解析");
        var explanation = firstNonBlank(candidate.correctedExplanation(), candidate.ocrText(), candidate.rawText(), "待人工补充解析");
        var options = decodeOptions(candidate.correctedOptions());
        return new QuestionDraftCommand(
                candidate.materialAssetId(),
                defaults.subjectCode(),
                defaults.chapterCode(),
                type,
                defaults.difficulty(),
                stem,
                answer,
                explanation,
                defaults.source(),
                defaults.sourceYear(),
                defaults.score(),
                "PLAIN_TEXT",
                null,
                options,
                defaults.knowledgePointCodes(),
                defaults.tags() == null ? List.of("拆题候选") : defaults.tags(),
                List.of(new QuestionDraftCommand.PageReferenceCommand(
                        candidate.materialAssetId(),
                        candidate.id(),
                        candidate.pageNumber(),
                        preview(firstNonBlank(candidate.ocrText(), candidate.rawText(), stem)),
                        "由拆题候选批量转草稿"
                )),
                userId.toString()
        );
    }

    private String encodeOptions(List<QuestionDraftCommand.OptionCommand> options) {
        if (options == null || options.isEmpty()) {
            return null;
        }
        return options.stream()
                .map(option -> escapeOption(option.label()) + "\t" + escapeOption(option.content()))
                .collect(Collectors.joining("\n"));
    }

    private List<QuestionDraftCommand.OptionCommand> decodeOptions(String value) {
        if (value == null || value.isBlank()) {
            return List.of();
        }
        return value.lines()
                .map(line -> line.split("\t", 2))
                .filter(parts -> parts.length == 2)
                .map(parts -> new QuestionDraftCommand.OptionCommand(unescapeOption(parts[0]), unescapeOption(parts[1])))
                .toList();
    }

    private String escapeOption(String value) {
        return text(value, "option").replace("\\", "\\\\").replace("\n", "\\n").replace("\t", "\\t");
    }

    private String unescapeOption(String value) {
        return value.replace("\\t", "\t").replace("\\n", "\n").replace("\\\\", "\\");
    }

    private String normalizeExtractedText(String text) {
        return text == null ? "" : text.replaceAll("\\s+", " ").trim();
    }

    private String suggestStem(String text) {
        var normalized = normalizeExtractedText(text);
        if (normalized.length() <= 180) {
            return normalized;
        }
        var questionMark = normalized.indexOf('？');
        if (questionMark < 40) {
            questionMark = normalized.indexOf('?');
        }
        if (questionMark >= 40 && questionMark < 180) {
            return normalized.substring(0, questionMark + 1);
        }
        return normalized.substring(0, 180);
    }

    private String fingerprint(String stem, List<QuestionDraftCommand.OptionCommand> options) {
        var normalized = normalizeForFingerprint(stem);
        try {
            var digest = MessageDigest.getInstance("SHA-256");
            return HexFormat.of().formatHex(digest.digest(normalized.getBytes(StandardCharsets.UTF_8)));
        } catch (NoSuchAlgorithmException exception) {
            throw new IllegalStateException("SHA-256 is not available", exception);
        }
    }

    private String normalizeForFingerprint(String value) {
        return value == null ? "" : value.toLowerCase(Locale.ROOT).replaceAll("\\s+", "");
    }

    private void upsertTextVector(String entityType, UUID entityId, String stem, String explanation) {
        var normalized = normalizeVectorText(stem + " " + (explanation == null ? "" : explanation));
        var vector = tokenVector(normalized).entrySet().stream()
                .sorted(Map.Entry.comparingByKey())
                .map(entry -> entry.getKey() + ":" + entry.getValue())
                .collect(Collectors.joining(" "));
        var params = new MapSqlParameterSource()
                .addValue("id", UUID.randomUUID())
                .addValue("entityType", entityType)
                .addValue("entityId", entityId)
                .addValue("normalizedText", normalized)
                .addValue("tokenVector", vector);
        jdbcTemplate.update("""
                DELETE FROM question_text_vectors
                WHERE entity_type = :entityType
                  AND entity_id = :entityId
                """, params);
        jdbcTemplate.update("""
                INSERT INTO question_text_vectors (id, entity_type, entity_id, normalized_text, token_vector, updated_at)
                VALUES (:id, :entityType, :entityId, :normalizedText, :tokenVector, CURRENT_TIMESTAMP)
                """, params);
    }

    private Map<String, Integer> tokenVector(String text) {
        var normalized = normalizeVectorText(text);
        var vector = new HashMap<String, Integer>();
        for (String token : normalized.split("\\s+")) {
            if (token.isBlank()) {
                continue;
            }
            vector.merge(token, 1, Integer::sum);
        }
        for (int index = 0; index < normalized.length() - 1; index++) {
            var current = normalized.charAt(index);
            var next = normalized.charAt(index + 1);
            if (isCjk(current)) {
                vector.merge(String.valueOf(current), 1, Integer::sum);
            }
            if (isCjk(current) && isCjk(next)) {
                vector.merge("" + current + next, 1, Integer::sum);
            }
        }
        if (!normalized.isEmpty() && isCjk(normalized.charAt(normalized.length() - 1))) {
            vector.merge(String.valueOf(normalized.charAt(normalized.length() - 1)), 1, Integer::sum);
        }
        return vector;
    }

    private String normalizeVectorText(String value) {
        return value == null
                ? ""
                : value.toLowerCase(Locale.ROOT)
                .replaceAll("[^\\p{IsHan}a-z0-9]+", " ")
                .replaceAll("\\s+", " ")
                .trim();
    }

    private boolean isCjk(char value) {
        return Character.UnicodeScript.of(value) == Character.UnicodeScript.HAN;
    }

    private double cosineSimilarity(Map<String, Integer> left, Map<String, Integer> right) {
        if (left.isEmpty() || right.isEmpty()) {
            return 0;
        }
        double dot = 0;
        for (var entry : left.entrySet()) {
            dot += entry.getValue() * right.getOrDefault(entry.getKey(), 0);
        }
        var leftNorm = Math.sqrt(left.values().stream().mapToDouble(value -> value * value).sum());
        var rightNorm = Math.sqrt(right.values().stream().mapToDouble(value -> value * value).sum());
        return leftNorm == 0 || rightNorm == 0 ? 0 : dot / (leftNorm * rightNorm);
    }

    private double roundSimilarity(double similarity) {
        return Math.round(similarity * 100.0) / 100.0;
    }

    private String firstNonBlank(String... values) {
        for (String value : values) {
            if (value != null && !value.isBlank()) {
                return value.trim();
            }
        }
        return null;
    }

    private String normalizeSource(String value) {
        var normalized = switch (value.trim()) {
            case "模拟", "模拟题", "MOCK", "SIMULATION" -> "MOCK";
            case "原创", "原创题", "ORIGINAL" -> "ORIGINAL";
            case "真题", "历年真题", "PAST_EXAM", "REAL_EXAM" -> "PAST_EXAM";
            default -> value.trim().toUpperCase(Locale.ROOT);
        };
        if (!SOURCES.contains(normalized)) {
            throw new IllegalArgumentException("Unsupported source: " + value);
        }
        return normalized;
    }

    private String normalizeQuestionType(String value) {
        var normalized = switch (value.trim()) {
            case "单选", "单选题", "选择题", "SINGLE_CHOICE" -> "SINGLE_CHOICE";
            case "多选", "多选题", "MULTIPLE_CHOICE" -> "MULTIPLE_CHOICE";
            case "综合题", "大题", "主观题", "COMPREHENSIVE" -> "COMPREHENSIVE";
            case "算法题", "算法设计题", "ALGORITHM" -> "ALGORITHM";
            case "计算题", "CALCULATION" -> "CALCULATION";
            default -> value.trim().toUpperCase(Locale.ROOT);
        };
        if (!TYPES.contains(normalized)) {
            throw new IllegalArgumentException("Unsupported type: " + value);
        }
        return normalized;
    }

    private String normalizeReviewerRole(String value) {
        if (value == null || value.isBlank()) {
            return "REVIEWER";
        }
        return normalizeAllowed(value, Set.of("AUTHOR", "REVIEWER", "ADMIN"), "reviewerRole");
    }

    private String normalizeAllowed(String value, Set<String> allowed, String fieldName) {
        var normalized = text(value, fieldName).toUpperCase(Locale.ROOT);
        if (!allowed.contains(normalized)) {
            throw new IllegalArgumentException("Unsupported " + fieldName + ": " + value);
        }
        return normalized;
    }

    private String normalizeOptionLabel(String value) {
        var label = text(value, "option.label").toUpperCase(Locale.ROOT);
        if (label.length() > 8) {
            throw new IllegalArgumentException("option.label is too long");
        }
        return label;
    }

    private String text(String value, String fieldName) {
        requireText(value, fieldName);
        return value.trim();
    }

    public record CandidateReviewCommand(
            String stem,
            String answer,
            String explanation,
            String type,
            List<QuestionDraftCommand.OptionCommand> options
    ) {
    }

    public record CandidateDraftDefaults(
            String subjectCode,
            String chapterCode,
            String difficulty,
            String source,
            Integer sourceYear,
            BigDecimal score,
            List<String> knowledgePointCodes,
            List<String> tags
    ) {
    }

    private void requireText(String value, String fieldName) {
        if (value == null || value.isBlank()) {
            throw new IllegalArgumentException(fieldName + " is required");
        }
    }

    private String blankToNull(String value) {
        return value == null || value.isBlank() ? null : value.trim();
    }

    private Integer nullableInteger(ResultSet rs, String column) throws SQLException {
        var value = rs.getInt(column);
        return rs.wasNull() ? null : value;
    }

    private Instant nullableInstant(ResultSet rs, String column) throws SQLException {
        var timestamp = rs.getTimestamp(column);
        return timestamp == null ? null : timestamp.toInstant();
    }

    private String preview(String value) {
        if (value == null) {
            return "";
        }
        return value.length() <= 80 ? value : value.substring(0, 80);
    }
}
