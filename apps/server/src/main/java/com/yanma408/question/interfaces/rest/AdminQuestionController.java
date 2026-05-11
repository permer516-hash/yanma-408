package com.yanma408.question.interfaces.rest;

import com.yanma408.question.application.command.CreateQuestionCommand;
import com.yanma408.question.application.command.QuestionImportValidationResult;
import com.yanma408.question.application.command.QuestionCommandService;
import com.yanma408.question.application.query.QuestionDetail;
import com.yanma408.question.application.query.QuestionQueryService;
import com.yanma408.question.application.query.QuestionSummary;
import com.yanma408.shared.exception.ResourceNotFoundException;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/admin/questions")
public class AdminQuestionController {
    private final QuestionQueryService questionQueryService;
    private final QuestionCommandService questionCommandService;

    public AdminQuestionController(
            QuestionQueryService questionQueryService,
            QuestionCommandService questionCommandService
    ) {
        this.questionQueryService = questionQueryService;
        this.questionCommandService = questionCommandService;
    }

    @GetMapping
    public List<QuestionSummary> list(@RequestParam(required = false) String subject) {
        return questionQueryService.listAll(subject);
    }

    @GetMapping("/{id}")
    public QuestionDetail detail(@PathVariable UUID id) {
        return questionQueryService.findDetail(id)
                .orElseThrow(() -> new ResourceNotFoundException("Question not found: " + id));
    }

    @PutMapping("/{id}")
    public QuestionDetail update(@PathVariable UUID id, @Valid @RequestBody QuestionFormRequest request) {
        questionCommandService.update(id, request.toCommand());
        return questionQueryService.findDetail(id)
                .orElseThrow(() -> new ResourceNotFoundException("Question not found: " + id));
    }

    @PatchMapping("/{id}/status")
    public QuestionDetail updateStatus(@PathVariable UUID id, @Valid @RequestBody UpdateQuestionStatusRequest request) {
        questionCommandService.updateStatus(id, request.status());
        return questionQueryService.findDetail(id)
                .orElseThrow(() -> new ResourceNotFoundException("Question not found: " + id));
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable UUID id) {
        questionCommandService.delete(id);
    }

    @PostMapping("/import")
    public List<QuestionDetail> bulkImport(@Valid @RequestBody BulkImportQuestionsRequest request) {
        var ids = questionCommandService.bulkCreate(
                request.questions().stream()
                        .map(QuestionFormRequest::toCommand)
                        .toList()
        );
        return ids.stream()
                .map(id -> questionQueryService.findDetail(id)
                        .orElseThrow(() -> new ResourceNotFoundException("Question not found: " + id)))
                .toList();
    }

    @PostMapping("/import/preview")
    public QuestionImportValidationResult previewImport(@RequestBody BulkImportQuestionsRequest request) {
        var questions = request == null ? null : request.questions();
        return questionCommandService.validateImport(
                questions == null ? null : questions.stream()
                        .map(QuestionFormRequest::toCommand)
                        .toList()
        );
    }

    @PostMapping(value = "/import/preview-file", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public QuestionImportValidationResult previewImportFile(@RequestParam("file") MultipartFile file) {
        var questions = parseImportFile(file);
        return questionCommandService.validateImport(
                questions.stream()
                        .map(QuestionFormRequest::toCommand)
                        .toList()
        );
    }

    @PostMapping(value = "/import/file", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public List<QuestionDetail> bulkImportFile(@RequestParam("file") MultipartFile file) {
        var ids = questionCommandService.bulkCreate(
                parseImportFile(file).stream()
                        .map(QuestionFormRequest::toCommand)
                        .toList()
        );
        return ids.stream()
                .map(id -> questionQueryService.findDetail(id)
                        .orElseThrow(() -> new ResourceNotFoundException("Question not found: " + id)))
                .toList();
    }

    public record BulkImportQuestionsRequest(
            @NotEmpty List<@Valid QuestionFormRequest> questions
    ) {
    }

    public record QuestionFormRequest(
            @NotBlank String subjectCode,
            @NotBlank String chapterCode,
            @NotBlank String type,
            @NotBlank String difficulty,
            @NotBlank @Size(max = 4000) String stem,
            @NotBlank String answer,
            @NotBlank @Size(max = 4000) String explanation,
            @NotBlank String source,
            Integer sourceYear,
            BigDecimal score,
            String stemFormat,
            String stemImageUrl,
            @NotEmpty List<@Valid OptionRequest> options,
            @NotEmpty List<@NotBlank String> knowledgePointCodes,
            List<String> tags
    ) {
        private CreateQuestionCommand toCommand() {
            return new CreateQuestionCommand(
                    subjectCode,
                    chapterCode,
                    type,
                    difficulty,
                    stem,
                    answer,
                    explanation,
                    source,
                    sourceYear,
                    score,
                    stemFormat,
                    stemImageUrl,
                    options.stream()
                            .map(option -> new CreateQuestionCommand.OptionCommand(option.label(), option.content()))
                            .toList(),
                    knowledgePointCodes,
                    tags
            );
        }
    }

    public record OptionRequest(
            @NotBlank String label,
            @NotBlank String content
    ) {
    }

    public record UpdateQuestionStatusRequest(
            @NotBlank String status
    ) {
    }

    @PatchMapping("/{id}/review")
    public QuestionDetail updateReviewStatus(
            @PathVariable UUID id,
            @RequestParam(defaultValue = "ADMIN") String role,
            @Valid @RequestBody UpdateQuestionReviewRequest request
    ) {
        if (!List.of("ADMIN", "REVIEWER").contains(role.trim().toUpperCase())) {
            throw new IllegalArgumentException("Unsupported reviewer role: " + role);
        }
        questionCommandService.updateReviewStatus(id, request.reviewStatus(), request.reviewNote());
        return questionQueryService.findDetail(id)
                .orElseThrow(() -> new ResourceNotFoundException("Question not found: " + id));
    }

    @PatchMapping("/bulk")
    public void bulkUpdate(@Valid @RequestBody BulkUpdateQuestionsRequest request) {
        questionCommandService.bulkUpdate(
                request.questionIds(),
                request.status(),
                request.reviewStatus(),
                request.tags()
        );
    }

    public record UpdateQuestionReviewRequest(
            @NotBlank String reviewStatus,
            String reviewNote
    ) {
    }

    public record BulkUpdateQuestionsRequest(
            @NotEmpty List<UUID> questionIds,
            String status,
            String reviewStatus,
            List<String> tags
    ) {
    }

    private List<QuestionFormRequest> parseImportFile(MultipartFile file) {
        if (file == null || file.isEmpty()) {
            throw new IllegalArgumentException("file is required");
        }
        var filename = file.getOriginalFilename() == null ? "" : file.getOriginalFilename().toLowerCase(Locale.ROOT);
        try {
            if (filename.endsWith(".csv")) {
                return parseCsv(file);
            }
            if (filename.endsWith(".xlsx") || filename.endsWith(".xls")) {
                return parseExcel(file);
            }
        } catch (IOException exception) {
            throw new IllegalArgumentException("Failed to read import file");
        }
        throw new IllegalArgumentException("Unsupported import file type");
    }

    private List<QuestionFormRequest> parseExcel(MultipartFile file) throws IOException {
        try (var workbook = WorkbookFactory.create(file.getInputStream())) {
            var sheet = workbook.getSheetAt(0);
            if (sheet == null || sheet.getPhysicalNumberOfRows() < 2) {
                throw new IllegalArgumentException("Import file must include a header row and at least one data row");
            }
            var formatter = new DataFormatter();
            var headers = readExcelHeaders(sheet.getRow(sheet.getFirstRowNum()), formatter);
            var rows = new ArrayList<QuestionFormRequest>();
            for (int rowIndex = sheet.getFirstRowNum() + 1; rowIndex <= sheet.getLastRowNum(); rowIndex++) {
                var values = readExcelRow(sheet.getRow(rowIndex), headers, formatter);
                if (!values.isEmpty()) {
                    rows.add(rowToQuestion(values));
                }
            }
            return requireRows(rows);
        }
    }

    private List<String> readExcelHeaders(Row row, DataFormatter formatter) {
        if (row == null) {
            throw new IllegalArgumentException("Import file header row is required");
        }
        var headers = new ArrayList<String>();
        for (int cellIndex = 0; cellIndex < row.getLastCellNum(); cellIndex++) {
            headers.add(formatter.formatCellValue(row.getCell(cellIndex)).trim());
        }
        return headers;
    }

    private Map<String, String> readExcelRow(Row row, List<String> headers, DataFormatter formatter) {
        var values = new HashMap<String, String>();
        if (row == null) {
            return values;
        }
        for (int index = 0; index < headers.size(); index++) {
            var header = headers.get(index);
            var value = formatter.formatCellValue(row.getCell(index)).trim();
            if (!header.isBlank() && !value.isBlank()) {
                values.put(header, value);
            }
        }
        return values;
    }

    private List<QuestionFormRequest> parseCsv(MultipartFile file) throws IOException {
        try (var reader = new BufferedReader(new InputStreamReader(file.getInputStream(), StandardCharsets.UTF_8))) {
            var headerLine = reader.readLine();
            if (headerLine == null || headerLine.isBlank()) {
                throw new IllegalArgumentException("Import file header row is required");
            }
            var headers = parseCsvLine(stripBom(headerLine));
            var rows = new ArrayList<QuestionFormRequest>();
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.isBlank()) {
                    continue;
                }
                var values = parseCsvLine(line);
                var row = new HashMap<String, String>();
                for (int index = 0; index < headers.size() && index < values.size(); index++) {
                    if (!headers.get(index).isBlank() && !values.get(index).isBlank()) {
                        row.put(headers.get(index), values.get(index));
                    }
                }
                if (!row.isEmpty()) {
                    rows.add(rowToQuestion(row));
                }
            }
            return requireRows(rows);
        }
    }

    private List<String> parseCsvLine(String line) {
        var values = new ArrayList<String>();
        var current = new StringBuilder();
        var quoted = false;
        for (int index = 0; index < line.length(); index++) {
            var currentChar = line.charAt(index);
            if (currentChar == '"') {
                if (quoted && index + 1 < line.length() && line.charAt(index + 1) == '"') {
                    current.append('"');
                    index++;
                } else {
                    quoted = !quoted;
                }
            } else if (currentChar == ',' && !quoted) {
                values.add(current.toString().trim());
                current.setLength(0);
            } else {
                current.append(currentChar);
            }
        }
        values.add(current.toString().trim());
        return values;
    }

    private List<QuestionFormRequest> requireRows(List<QuestionFormRequest> rows) {
        if (rows.isEmpty()) {
            throw new IllegalArgumentException("At least one question is required");
        }
        return rows;
    }

    private QuestionFormRequest rowToQuestion(Map<String, String> row) {
        var subjectCode = normalizeSubject(cell(row, "subjectCode", "科目", "subject"));
        var defaults = SUBJECT_DEFAULTS.getOrDefault(subjectCode, SUBJECT_DEFAULTS.get("DATA_STRUCTURE"));
        var knowledgePointCodes = splitList(cell(row, "knowledgePointCodes", "知识点编码"));
        return new QuestionFormRequest(
                subjectCode,
                valueOrDefault(cell(row, "chapterCode", "章节编码"), defaults.chapterCode()),
                valueOrDefault(cell(row, "type", "题型"), "SINGLE_CHOICE"),
                normalizeDifficulty(valueOrDefault(cell(row, "difficulty", "难度"), "BASIC")),
                cell(row, "stem", "题干"),
                valueOrDefault(cell(row, "answer", "答案"), "A"),
                cell(row, "explanation", "解析"),
                valueOrDefault(cell(row, "source", "来源"), "ORIGINAL"),
                integerOrNull(cell(row, "sourceYear", "年份")),
                decimalOrDefault(cell(row, "score", "分值"), BigDecimal.valueOf(2)),
                valueOrDefault(cell(row, "stemFormat", "题干格式"), "PLAIN_TEXT"),
                nullIfBlank(cell(row, "stemImageUrl", "题图")),
                List.of("A", "B", "C", "D").stream()
                        .map(label -> new OptionRequest(label, cell(row, "option" + label, label + "选项", "选项" + label)))
                        .filter(option -> !option.content().isBlank())
                        .toList(),
                knowledgePointCodes.isEmpty() ? List.of(defaults.knowledgePointCode()) : knowledgePointCodes,
                splitList(cell(row, "tags", "标签"))
        );
    }

    private String cell(Map<String, String> row, String... keys) {
        for (String key : keys) {
            var value = row.get(key);
            if (value != null && !value.isBlank()) {
                return value.trim();
            }
        }
        return "";
    }

    private String normalizeSubject(String value) {
        if (value == null || value.isBlank()) {
            return "DATA_STRUCTURE";
        }
        return switch (value.trim()) {
            case "数据结构", "DATA_STRUCTURE" -> "DATA_STRUCTURE";
            case "计组", "计算机组成原理", "COMPUTER_ORGANIZATION" -> "COMPUTER_ORGANIZATION";
            case "操作系统", "OPERATING_SYSTEM" -> "OPERATING_SYSTEM";
            case "计网", "计算机网络", "COMPUTER_NETWORK" -> "COMPUTER_NETWORK";
            default -> value.trim().toUpperCase(Locale.ROOT);
        };
    }

    private String normalizeDifficulty(String value) {
        return switch (value.trim()) {
            case "基础" -> "BASIC";
            case "中等" -> "MEDIUM";
            case "困难" -> "HARD";
            default -> value;
        };
    }

    private List<String> splitList(String value) {
        if (value == null || value.isBlank()) {
            return List.of();
        }
        return List.of(value.split("[,，;；]")).stream()
                .map(String::trim)
                .filter(item -> !item.isBlank())
                .toList();
    }

    private String valueOrDefault(String value, String defaultValue) {
        return value == null || value.isBlank() ? defaultValue : value.trim();
    }

    private String nullIfBlank(String value) {
        return value == null || value.isBlank() ? null : value.trim();
    }

    private Integer integerOrNull(String value) {
        if (value == null || value.isBlank()) {
            return null;
        }
        return Integer.valueOf(value.trim());
    }

    private BigDecimal decimalOrDefault(String value, BigDecimal defaultValue) {
        if (value == null || value.isBlank()) {
            return defaultValue;
        }
        return new BigDecimal(value.trim());
    }

    private String stripBom(String value) {
        return value.startsWith("\uFEFF") ? value.substring(1) : value;
    }

    private static final Map<String, SubjectDefaults> SUBJECT_DEFAULTS = Map.of(
            "DATA_STRUCTURE", new SubjectDefaults("DS_TREE", "DS_TREE_TRAVERSAL"),
            "COMPUTER_ORGANIZATION", new SubjectDefaults("CO_CACHE", "CO_CACHE_MAPPING"),
            "OPERATING_SYSTEM", new SubjectDefaults("OS_PROCESS", "OS_SCHEDULING"),
            "COMPUTER_NETWORK", new SubjectDefaults("CN_TRANSPORT", "CN_TCP_CONGESTION")
    );

    private record SubjectDefaults(String chapterCode, String knowledgePointCode) {
    }
}
