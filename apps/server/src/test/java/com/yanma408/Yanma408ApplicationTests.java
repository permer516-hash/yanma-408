package com.yanma408;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.security.test.context.support.WithMockUser;

import java.util.List;
import java.util.UUID;
import java.security.MessageDigest;
import java.nio.charset.StandardCharsets;
import java.util.HexFormat;

import static org.hamcrest.Matchers.containsInAnyOrder;
import static org.hamcrest.Matchers.hasSize;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.multipart;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.patch;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
@ActiveProfiles("test")
@WithMockUser(username = "00000000-0000-0000-0000-000000000001")
class Yanma408ApplicationTests {
    private static final UUID DEV_USER_ID = UUID.fromString("00000000-0000-0000-0000-000000000001");
    private static final UUID OTHER_USER_ID = UUID.fromString("00000000-0000-0000-0000-000000000999");
    private static final UUID QUESTION_ID = UUID.fromString("00000000-0000-0000-0000-000000000401");
    private static final UUID ATTEMPT_ID = UUID.fromString("10000000-0000-0000-0000-000000000001");
    private static final UUID MISTAKE_ID = UUID.fromString("20000000-0000-0000-0000-000000000001");
    private static final UUID STUDY_TASK_ID = UUID.fromString("00000000-0000-0000-0000-000000000702");

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @BeforeEach
    void setUp() {
        jdbcTemplate.update("DELETE FROM mistakes");
        jdbcTemplate.update("DELETE FROM practice_attempts");
        jdbcTemplate.update("DELETE FROM exam_attempt_answers");
        jdbcTemplate.update("DELETE FROM exam_attempts");
        jdbcTemplate.update("DELETE FROM study_notifications");
        jdbcTemplate.update("DELETE FROM study_task_occurrences");
        jdbcTemplate.update("DELETE FROM study_plan_tasks");
        jdbcTemplate.update("DELETE FROM auth_audit_logs");
        jdbcTemplate.update("DELETE FROM auth_tokens");
        jdbcTemplate.update("DELETE FROM question_tag_relations");
        jdbcTemplate.update("DELETE FROM question_tags");
        jdbcTemplate.update("""
                UPDATE app_users
                SET password_hash = '{noop}yanma408',
                    password_reset_token_hash = null,
                    password_reset_expires_at = null,
                    updated_at = CURRENT_TIMESTAMP
                WHERE id = ?
                """, DEV_USER_ID);
        jdbcTemplate.update("""
                DELETE FROM questions
                WHERE id NOT IN (
                    '00000000-0000-0000-0000-000000000401',
                    '00000000-0000-0000-0000-000000000402'
                )
                """);
        jdbcTemplate.update("""
                DELETE FROM question_options
                WHERE question_id IN (
                    '00000000-0000-0000-0000-000000000401',
                    '00000000-0000-0000-0000-000000000402'
                )
                """);
        jdbcTemplate.update("""
                DELETE FROM question_knowledge_points
                WHERE question_id IN (
                    '00000000-0000-0000-0000-000000000401',
                    '00000000-0000-0000-0000-000000000402'
                )
                """);
        jdbcTemplate.update("""
                UPDATE questions
                SET subject_id = '00000000-0000-0000-0000-000000000101',
                    chapter_id = '00000000-0000-0000-0000-000000000201',
                    type = 'SINGLE_CHOICE',
                    difficulty = 'BASIC',
                    stem = '若一棵二叉树的先序序列为 A B D E C， 中序序列为 D B E A C，则该二叉树的后序序列是？',
                    answer = 'B',
                    explanation = '先序序列首元素 A 为根；中序序列中 A 左侧为 D B E，右侧为 C。递归确定左右子树后，后序序列为 D E B C A。',
                    source = 'ORIGINAL',
                    source_year = null,
                    score = 2.00,
                    status = 'PUBLISHED',
                    review_status = 'APPROVED',
                    review_note = null,
                    reviewed_at = null,
                    stem_format = 'PLAIN_TEXT',
                    stem_image_url = null
                WHERE id = '00000000-0000-0000-0000-000000000401'
                """);
        jdbcTemplate.update("""
                UPDATE questions
                SET subject_id = '00000000-0000-0000-0000-000000000102',
                    chapter_id = '00000000-0000-0000-0000-000000000202',
                    type = 'SINGLE_CHOICE',
                    difficulty = 'MEDIUM',
                    stem = '某 Cache 采用 4 路组相联映射，主存块号为 37，Cache 共有 8 组，则该主存块应映射到哪一组？',
                    answer = 'C',
                    explanation = '组相联映射中组号等于主存块号对 Cache 组数取模，37 mod 8 = 5。',
                    source = 'ORIGINAL',
                    source_year = null,
                    score = 2.00,
                    status = 'PUBLISHED',
                    review_status = 'APPROVED',
                    review_note = null,
                    reviewed_at = null,
                    stem_format = 'PLAIN_TEXT',
                    stem_image_url = null
                WHERE id = '00000000-0000-0000-0000-000000000402'
                """);
        jdbcTemplate.update("""
                INSERT INTO question_options (id, question_id, label, content, sort_order) VALUES
                ('00000000-0000-0000-0000-000000000501', '00000000-0000-0000-0000-000000000401', 'A', 'D B E C A', 1),
                ('00000000-0000-0000-0000-000000000502', '00000000-0000-0000-0000-000000000401', 'B', 'D E B C A', 2),
                ('00000000-0000-0000-0000-000000000503', '00000000-0000-0000-0000-000000000401', 'C', 'D E C B A', 3),
                ('00000000-0000-0000-0000-000000000504', '00000000-0000-0000-0000-000000000401', 'D', 'B D E C A', 4),
                ('00000000-0000-0000-0000-000000000505', '00000000-0000-0000-0000-000000000402', 'A', '第 1 组', 1),
                ('00000000-0000-0000-0000-000000000506', '00000000-0000-0000-0000-000000000402', 'B', '第 4 组', 2),
                ('00000000-0000-0000-0000-000000000507', '00000000-0000-0000-0000-000000000402', 'C', '第 5 组', 3),
                ('00000000-0000-0000-0000-000000000508', '00000000-0000-0000-0000-000000000402', 'D', '第 7 组', 4)
                """);
        jdbcTemplate.update("""
                INSERT INTO question_knowledge_points (question_id, knowledge_point_id) VALUES
                ('00000000-0000-0000-0000-000000000401', '00000000-0000-0000-0000-000000000301'),
                ('00000000-0000-0000-0000-000000000402', '00000000-0000-0000-0000-000000000302')
                """);
        jdbcTemplate.update("""
                INSERT INTO study_plan_tasks (
                    id, user_id, title, subject_code, task_type, target_count,
                    estimated_minutes, status, priority, task_date, created_at, updated_at
                ) VALUES
                (?, ?, '网络层选择题', 'COMPUTER_NETWORK', 'QUESTION_SET', 20, 22, 'PENDING', 'NORMAL', CURRENT_DATE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
                (?, ?, 'Cache 映射专题', 'COMPUTER_ORGANIZATION', 'WEAK_POINT', 10, 15, 'PENDING', 'IMPORTANT', CURRENT_DATE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
                (?, ?, '错题回炉', 'DATA_STRUCTURE', 'MISTAKE_REVIEW', 15, 20, 'PENDING', 'REVIEW', CURRENT_DATE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
                """,
                UUID.fromString("00000000-0000-0000-0000-000000000701"), DEV_USER_ID,
                STUDY_TASK_ID, DEV_USER_ID,
                UUID.fromString("00000000-0000-0000-0000-000000000703"), DEV_USER_ID
        );
        jdbcTemplate.update("""
                INSERT INTO practice_attempts (
                    id, user_id, question_id, submitted_answer, correct_answer,
                    correct, elapsed_seconds, submitted_at
                ) VALUES (?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP)
                """, ATTEMPT_ID, DEV_USER_ID, QUESTION_ID, "A", "B", false, 12);
        jdbcTemplate.update("""
                INSERT INTO mistakes (
                    id, user_id, question_id, first_wrong_attempt_id, latest_wrong_attempt_id,
                    wrong_count, mastered, reason, created_at, updated_at
                ) VALUES (?, ?, ?, ?, ?, ?, ?, null, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
                """, MISTAKE_ID, DEV_USER_ID, QUESTION_ID, ATTEMPT_ID, ATTEMPT_ID, 1, true);
    }

    @Test
    void contextLoads() {
    }

    @Test
    void mistakesQueryIgnoresClientUserId() throws Exception {
        mockMvc.perform(get("/mistakes").param("userId", OTHER_USER_ID.toString()))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$", hasSize(1)))
                .andExpect(jsonPath("$[0].id").value(MISTAKE_ID.toString()));
    }

    @Test
    void updateMissingMistakeReturnsNotFound() throws Exception {
        mockMvc.perform(patch("/mistakes/00000000-0000-0000-0000-000000009999/mastery")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"mastered\":true}"))
                .andExpect(status().isNotFound())
                .andExpect(jsonPath("$.code").value("NOT_FOUND"));
    }

    @Test
    void submitAttemptRejectsElapsedSecondsOverflow() throws Exception {
        mockMvc.perform(post("/practice/attempts")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "userId": "00000000-0000-0000-0000-000000000999",
                                  "questionId": "00000000-0000-0000-0000-000000000401",
                                  "submittedAnswer": "B",
                                  "elapsedSeconds": 2147483648
                                }
                                """))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.code").value("BAD_REQUEST"));
    }

    @Test
    void studyDashboardReturnsWeakKnowledgePoints() throws Exception {
        mockMvc.perform(get("/study/dashboard"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.todayGoal.completedCount").value(1))
                .andExpect(jsonPath("$.todayGoal.targetCount").value(60))
                .andExpect(jsonPath("$.continuousStudy.days").value(1))
                .andExpect(jsonPath("$.weeklyAccuracy.percent").value(0))
                .andExpect(jsonPath("$.weeklyAccuracy.attemptCount").value(1))
                .andExpect(jsonPath("$.subjectMasteries", hasSize(4)))
                .andExpect(jsonPath("$.subjectMasteries[0].subjectCode").value("DATA_STRUCTURE"))
                .andExpect(jsonPath("$.subjectMasteries[0].practicedCount").value(1))
                .andExpect(jsonPath("$.todayTasks", hasSize(3)))
                .andExpect(jsonPath("$.weakKnowledgePoints", hasSize(1)))
                .andExpect(jsonPath("$.weakKnowledgePoints[0].name").value("二叉树遍历"))
                .andExpect(jsonPath("$.weakKnowledgePoints[0].wrongCount").value(1));
    }

    @Test
    void updateStudyTaskStatusChangesTodayTask() throws Exception {
        mockMvc.perform(patch("/study/tasks/{id}/status", STUDY_TASK_ID)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"status\":\"DONE\"}"))
                .andExpect(status().isOk());

        mockMvc.perform(get("/study/dashboard"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.todayTasks[0].id").value(STUDY_TASK_ID.toString()))
                .andExpect(jsonPath("$.todayTasks[0].status").value("DONE"));
    }

    @Test
    void updateMissingStudyTaskReturnsNotFound() throws Exception {
        mockMvc.perform(patch("/study/tasks/00000000-0000-0000-0000-000000009999/status")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"status\":\"DONE\"}"))
                .andExpect(status().isNotFound())
                .andExpect(jsonPath("$.code").value("NOT_FOUND"));
    }

    @Test
    void updateStudyTaskRejectsUnsupportedStatus() throws Exception {
        mockMvc.perform(patch("/study/tasks/{id}/status", STUDY_TASK_ID)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"status\":\"SKIPPED\"}"))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.code").value("BAD_REQUEST"));
    }

    @Test
    void createStudyTaskAddsTodayTask() throws Exception {
        mockMvc.perform(post("/study/tasks")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "title": "操作系统调度补练",
                                  "subjectCode": "OPERATING_SYSTEM",
                                  "taskType": "CUSTOM",
                                  "targetCount": 8,
                                  "estimatedMinutes": 18,
                                  "priority": "NORMAL"
                                }
                                """))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.title").value("操作系统调度补练"))
                .andExpect(jsonPath("$.status").value("PENDING"));

        mockMvc.perform(get("/study/dashboard"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.todayTasks", hasSize(4)));
    }

    @Test
    void createStudyTaskRejectsUnsupportedSubject() throws Exception {
        mockMvc.perform(post("/study/tasks")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "title": "错误科目任务",
                                  "subjectCode": "MATH",
                                  "taskType": "CUSTOM",
                                  "targetCount": 8,
                                  "estimatedMinutes": 18,
                                  "priority": "NORMAL"
                                }
                                """))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.code").value("BAD_REQUEST"));
    }

    @Test
    void examsListReturnsPublishedPapers() throws Exception {
        mockMvc.perform(get("/exams"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$", hasSize(1)))
                .andExpect(jsonPath("$[0].title").value("408 迷你模拟卷 A"))
                .andExpect(jsonPath("$[0].questionCount").value(2));
    }

    @Test
    void studyTasksCanBeQueriedUpdatedAndDeleted() throws Exception {
        mockMvc.perform(get("/study/tasks").param("date", java.time.LocalDate.now().toString()))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$", hasSize(3)));

        mockMvc.perform(patch("/study/tasks/{id}/status", STUDY_TASK_ID)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"status\":\"DONE\"}"))
                .andExpect(status().isOk());

        mockMvc.perform(put("/study/tasks/{id}", STUDY_TASK_ID)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "title": "Cache 映射专题改",
                                  "subjectCode": "COMPUTER_ORGANIZATION",
                                  "taskType": "WEAK_POINT",
                                  "targetCount": 12,
                                  "estimatedMinutes": 20,
                                  "priority": "IMPORTANT"
                                }
                                """))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.title").value("Cache 映射专题改"))
                .andExpect(jsonPath("$.status").value("DONE"));

        mockMvc.perform(delete("/study/tasks/{id}", STUDY_TASK_ID))
                .andExpect(status().isOk());

        mockMvc.perform(get("/study/tasks").param("date", java.time.LocalDate.now().toString()))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$", hasSize(2)));
    }

    @Test
    void examDetailReturnsQuestions() throws Exception {
        mockMvc.perform(get("/exams/00000000-0000-0000-0000-000000000801"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.title").value("408 迷你模拟卷 A"))
                .andExpect(jsonPath("$.questions", hasSize(2)))
                .andExpect(jsonPath("$.questions[0].id").value(QUESTION_ID.toString()));
    }

    @Test
    void createQuestionAndAdminListWork() throws Exception {
        mockMvc.perform(post("/questions")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "subjectCode": "OPERATING_SYSTEM",
                                  "chapterCode": "OS_PROCESS",
                                  "type": "SINGLE_CHOICE",
                                  "difficulty": "BASIC",
                                  "stem": "在时间片轮转调度中，时间片过大时算法退化为哪类调度？",
                                  "answer": "A",
                                  "explanation": "时间片很大时，进程通常会在一个时间片内运行至结束，行为接近先来先服务。",
                                  "source": "ORIGINAL",
                                  "score": 2,
                                  "options": [
                                    {"label": "A", "content": "先来先服务"},
                                    {"label": "B", "content": "短作业优先"},
                                    {"label": "C", "content": "最高响应比优先"},
                                    {"label": "D", "content": "多级反馈队列"}
                                  ],
                                  "knowledgePointCodes": ["OS_SCHEDULING"]
                                }
                                """))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.subjectCode").value("OPERATING_SYSTEM"))
                .andExpect(jsonPath("$.knowledgePoints[0].name").value("处理机调度"));

        mockMvc.perform(get("/admin/questions").param("subject", "OPERATING_SYSTEM"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$", hasSize(1)))
                .andExpect(jsonPath("$[0].stem").value("在时间片轮转调度中，时间片过大时算法退化为哪类调度？"));
    }

    @Test
    void examAttemptCanBeSubmittedAndReported() throws Exception {
        var startResponse = mockMvc.perform(post("/exams/00000000-0000-0000-0000-000000000801/attempts"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.status").value("STARTED"))
                .andExpect(jsonPath("$.paper.questions", hasSize(2)))
                .andReturn()
                .getResponse()
                .getContentAsString();
        var attemptId = com.jayway.jsonpath.JsonPath.read(startResponse, "$.id").toString();

        mockMvc.perform(post("/exams/attempts/{id}/submit", attemptId)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "durationSeconds": 120,
                                  "answers": {
                                    "00000000-0000-0000-0000-000000000401": "B",
                                    "00000000-0000-0000-0000-000000000402": "A"
                                  }
                                }
                                """))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.status").value("SUBMITTED"))
                .andExpect(jsonPath("$.correctCount").value(1))
                .andExpect(jsonPath("$.questionCount").value(2))
                .andExpect(jsonPath("$.accuracyPercent").value(50))
                .andExpect(jsonPath("$.results", hasSize(2)))
                .andExpect(jsonPath("$.results[0].correct").value(true))
                .andExpect(jsonPath("$.results[1].correct").value(false));

        mockMvc.perform(get("/exams/attempts/{id}/report", attemptId))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.durationSeconds").value(120))
                .andExpect(jsonPath("$.results", hasSize(2)));
    }

    @Test
    void adminQuestionManagementSupportsStatusUpdateSoftDeleteAndImport() throws Exception {
        mockMvc.perform(patch("/admin/questions/{id}/status", QUESTION_ID)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"status\":\"DRAFT\"}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.status").value("DRAFT"));

        mockMvc.perform(get("/questions/{id}", QUESTION_ID))
                .andExpect(status().isNotFound());

        mockMvc.perform(patch("/admin/questions/{id}/status", QUESTION_ID)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"status\":\"PUBLISHED\"}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.status").value("PUBLISHED"));

        mockMvc.perform(put("/admin/questions/{id}", QUESTION_ID)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "subjectCode": "DATA_STRUCTURE",
                                  "chapterCode": "DS_TREE",
                                  "type": "SINGLE_CHOICE",
                                  "difficulty": "MEDIUM",
                                  "stem": "更新后的二叉树遍历题干",
                                  "answer": "C",
                                  "explanation": "更新后的解析",
                                  "source": "ORIGINAL",
                                  "score": 3,
                                  "options": [
                                    {"label": "A", "content": "选项 A"},
                                    {"label": "B", "content": "选项 B"},
                                    {"label": "C", "content": "选项 C"},
                                    {"label": "D", "content": "选项 D"}
                                  ],
                                  "knowledgePointCodes": ["DS_TREE_TRAVERSAL"]
                                }
                                """))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.stem").value("更新后的二叉树遍历题干"))
                .andExpect(jsonPath("$.answer").value("C"));

        mockMvc.perform(post("/admin/questions/import")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "questions": [
                                    {
                                      "subjectCode": "COMPUTER_NETWORK",
                                      "chapterCode": "CN_TRANSPORT",
                                      "type": "SINGLE_CHOICE",
                                      "difficulty": "BASIC",
                                      "stem": "TCP 拥塞控制中慢开始阶段窗口如何变化？",
                                      "answer": "A",
                                      "explanation": "慢开始阶段拥塞窗口按指数增长。",
                                      "source": "ORIGINAL",
                                      "score": 2,
                                      "options": [
                                        {"label": "A", "content": "指数增长"},
                                        {"label": "B", "content": "线性增长"},
                                        {"label": "C", "content": "保持不变"},
                                        {"label": "D", "content": "立即减半"}
                                      ],
                                      "knowledgePointCodes": ["CN_TCP_CONGESTION"]
                                    }
                                  ]
                                }
                                """))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$", hasSize(1)))
                .andExpect(jsonPath("$[0].subjectCode").value("COMPUTER_NETWORK"));

        mockMvc.perform(delete("/admin/questions/{id}", QUESTION_ID))
                .andExpect(status().isOk());

        mockMvc.perform(get("/admin/questions").param("subject", "DATA_STRUCTURE"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].status").value("DELETED"));
    }

    @Test
    void recurringStudyTasksAppearInRangeWithReminder() throws Exception {
        mockMvc.perform(post("/study/tasks")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "title": "每日错题提醒",
                                  "subjectCode": "DATA_STRUCTURE",
                                  "taskType": "MISTAKE_REVIEW",
                                  "targetCount": 5,
                                  "estimatedMinutes": 12,
                                  "priority": "REVIEW",
                                  "taskDate": "2026-05-01",
                                  "recurrenceRule": "DAILY",
                                  "reminderTime": "21:30"
                                }
                                """))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.recurrenceRule").value("DAILY"))
                .andExpect(jsonPath("$.reminderTime").value("21:30:00"));

        mockMvc.perform(get("/study/tasks/range")
                        .param("start", "2026-05-06")
                        .param("end", "2026-05-12"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].title").value("每日错题提醒"))
                .andExpect(jsonPath("$[0].taskDate").value("2026-05-06"))
                .andExpect(jsonPath("$[0].recurrenceRule").value("DAILY"));
    }

    @Test
    void studyTaskOccurrenceStatusSupportsSkipWithoutChangingTemplate() throws Exception {
        mockMvc.perform(post("/study/tasks")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "title": "每周网络复盘",
                                  "subjectCode": "COMPUTER_NETWORK",
                                  "taskType": "QUESTION_SET",
                                  "targetCount": 10,
                                  "estimatedMinutes": 30,
                                  "priority": "NORMAL",
                                  "taskDate": "2026-05-06",
                                  "recurrenceRule": "WEEKLY",
                                  "reminderTime": "08:15"
                                }
                                """))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.recurrenceRule").value("WEEKLY"));

        var createdTaskId = jdbcTemplate.queryForObject(
                "SELECT id FROM study_plan_tasks WHERE title = '每周网络复盘'",
                UUID.class
        );

        mockMvc.perform(patch("/study/tasks/{id}/occurrences/2026-05-13/status", createdTaskId)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"status\":\"SKIPPED\"}"))
                .andExpect(status().isOk());

        var firstOccurrenceTasks = mockMvc.perform(get("/study/tasks").param("date", "2026-05-06"))
                .andExpect(status().isOk())
                .andReturn()
                .getResponse()
                .getContentAsString();
        assertEquals("PENDING", statusForTask(firstOccurrenceTasks, "每周网络复盘"));

        var skippedOccurrenceTasks = mockMvc.perform(get("/study/tasks").param("date", "2026-05-13"))
                .andExpect(status().isOk())
                .andReturn()
                .getResponse()
                .getContentAsString();
        assertEquals("SKIPPED", statusForTask(skippedOccurrenceTasks, "每周网络复盘"));

        mockMvc.perform(get("/study/reminders").param("date", "2026-05-13"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$", hasSize(0)));
    }

    @Test
    void examAttemptHistoryAndComparisonUseLatestSubmittedAttempts() throws Exception {
        var firstAttemptId = startExamAttempt();
        submitExamAttempt(firstAttemptId, "B", "C")
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.accuracyPercent").value(100));

        var secondAttemptId = startExamAttempt();
        submitExamAttempt(secondAttemptId, "B", "A")
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.accuracyPercent").value(50));

        mockMvc.perform(get("/exams/00000000-0000-0000-0000-000000000801/attempts"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$", hasSize(2)))
                .andExpect(jsonPath("$[0].id").value(secondAttemptId))
                .andExpect(jsonPath("$[0].accuracyPercent").value(50))
                .andExpect(jsonPath("$[1].id").value(firstAttemptId))
                .andExpect(jsonPath("$[1].accuracyPercent").value(100));

        mockMvc.perform(get("/exams/00000000-0000-0000-0000-000000000801/attempts/compare"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.latest.id").value(secondAttemptId))
                .andExpect(jsonPath("$.previous.id").value(firstAttemptId))
                .andExpect(jsonPath("$.scoreDelta").value(-2))
                .andExpect(jsonPath("$.accuracyDelta").value(-50))
                .andExpect(jsonPath("$.questions", hasSize(2)))
                .andExpect(jsonPath("$.questions[1].latestCorrect").value(false))
                .andExpect(jsonPath("$.questions[1].previousCorrect").value(true));
    }

    @Test
    void adminQuestionReviewTagsAndBulkUpdateControlPublicQuestionBank() throws Exception {
        mockMvc.perform(patch("/admin/questions/{id}/review", QUESTION_ID)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"reviewStatus\":\"PENDING\",\"reviewNote\":\"题干需补充来源\"}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.reviewStatus").value("PENDING"))
                .andExpect(jsonPath("$.reviewNote").value("题干需补充来源"));

        mockMvc.perform(get("/questions/{id}", QUESTION_ID))
                .andExpect(status().isNotFound());

        mockMvc.perform(put("/admin/questions/{id}", QUESTION_ID)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "subjectCode": "DATA_STRUCTURE",
                                  "chapterCode": "DS_TREE",
                                  "type": "SINGLE_CHOICE",
                                  "difficulty": "BASIC",
                                  "stem": "**Markdown** 题干",
                                  "answer": "B",
                                  "explanation": "支持 Markdown 题干和题图地址。",
                                  "source": "ORIGINAL",
                                  "score": 2,
                                  "stemFormat": "MARKDOWN",
                                  "stemImageUrl": "https://example.com/tree.png",
                                  "options": [
                                    {"label": "A", "content": "D B E C A"},
                                    {"label": "B", "content": "D E B C A"},
                                    {"label": "C", "content": "D E C B A"},
                                    {"label": "D", "content": "B D E C A"}
                                  ],
                                  "knowledgePointCodes": ["DS_TREE_TRAVERSAL"],
                                  "tags": ["真题", "二叉树"]
                                }
                                """))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.stemFormat").value("MARKDOWN"))
                .andExpect(jsonPath("$.stemImageUrl").value("https://example.com/tree.png"))
                .andExpect(jsonPath("$.tags", hasSize(2)));

        mockMvc.perform(patch("/admin/questions/bulk")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "questionIds": [
                                    "00000000-0000-0000-0000-000000000401",
                                    "00000000-0000-0000-0000-000000000402"
                                  ],
                                  "reviewStatus": "REJECTED",
                                  "tags": ["需重审", "408"]
                                }
                                """))
                .andExpect(status().isOk());

        mockMvc.perform(get("/questions"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$", hasSize(0)));

        mockMvc.perform(get("/admin/questions"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].reviewStatus").value("REJECTED"))
                .andExpect(jsonPath("$[0].tags", containsInAnyOrder("需重审", "408")));
    }

    @Test
    void importPreviewReturnsRowLevelErrors() throws Exception {
        mockMvc.perform(post("/admin/questions/import/preview")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "questions": [
                                    {
                                      "subjectCode": "DATA_STRUCTURE",
                                      "chapterCode": "DS_TREE",
                                      "type": "SINGLE_CHOICE",
                                      "difficulty": "BASIC",
                                      "stem": "合法导入题",
                                      "answer": "A",
                                      "explanation": "合法解析",
                                      "source": "ORIGINAL",
                                      "score": 2,
                                      "options": [
                                        {"label": "A", "content": "正确"},
                                        {"label": "B", "content": "错误"}
                                      ],
                                      "knowledgePointCodes": ["DS_TREE_TRAVERSAL"]
                                    },
                                    {
                                      "subjectCode": "DATA_STRUCTURE",
                                      "chapterCode": "DS_TREE",
                                      "type": "SINGLE_CHOICE",
                                      "difficulty": "BASIC",
                                      "stem": "非法知识点导入题",
                                      "answer": "A",
                                      "explanation": "非法解析",
                                      "source": "ORIGINAL",
                                      "score": 2,
                                      "options": [
                                        {"label": "A", "content": "正确"},
                                        {"label": "B", "content": "错误"}
                                      ],
                                      "knowledgePointCodes": ["UNKNOWN_POINT"]
                                    }
                                  ]
                                }
                                """))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.totalRows").value(2))
                .andExpect(jsonPath("$.validRows").value(1))
                .andExpect(jsonPath("$.invalidRows").value(1))
                .andExpect(jsonPath("$.errors[0].rowNumber").value(2));
    }

    @Test
    void importFilePreviewAndImportSupportsCsvUpload() throws Exception {
        var csv = """
                subjectCode,chapterCode,type,difficulty,stem,answer,explanation,source,score,optionA,optionB,knowledgePointCodes
                DATA_STRUCTURE,DS_TREE,SINGLE_CHOICE,BASIC,CSV导入题,A,CSV解析,ORIGINAL,2,正确,错误,DS_TREE_TRAVERSAL
                """;
        var previewFile = new MockMultipartFile(
                "file",
                "questions.csv",
                "text/csv",
                csv.getBytes(StandardCharsets.UTF_8)
        );

        mockMvc.perform(multipart("/admin/questions/import/preview-file").file(previewFile))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.totalRows").value(1))
                .andExpect(jsonPath("$.validRows").value(1))
                .andExpect(jsonPath("$.invalidRows").value(0));

        var importFile = new MockMultipartFile(
                "file",
                "questions.csv",
                "text/csv",
                csv.getBytes(StandardCharsets.UTF_8)
        );

        mockMvc.perform(multipart("/admin/questions/import/file").file(importFile))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$", hasSize(1)))
                .andExpect(jsonPath("$[0].stem").value("CSV导入题"));
    }

    @Test
    void questionSearchSupportsFiltersAndPagination() throws Exception {
        mockMvc.perform(get("/questions/search")
                        .param("keyword", "二叉树")
                        .param("difficulty", "BASIC")
                        .param("knowledgePoint", "DS_TREE_TRAVERSAL")
                        .param("page", "0")
                        .param("size", "1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.total").value(1))
                .andExpect(jsonPath("$.totalPages").value(1))
                .andExpect(jsonPath("$.items", hasSize(1)))
                .andExpect(jsonPath("$.items[0].id").value(QUESTION_ID.toString()));
    }

    @Test
    void mistakeReviewQueueReturnsPendingMistakesByPriority() throws Exception {
        mockMvc.perform(get("/mistakes/review-queue"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$", hasSize(0)));

        mockMvc.perform(patch("/mistakes/{id}/mastery", MISTAKE_ID)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"mastered\":false}"))
                .andExpect(status().isOk());

        mockMvc.perform(get("/mistakes/review-queue"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$", hasSize(1)))
                .andExpect(jsonPath("$[0].id").value(MISTAKE_ID.toString()));
    }

    @Test
    void logoutRevokesBearerToken() throws Exception {
        var loginResponse = mockMvc.perform(post("/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"username\":\"demo\",\"password\":\"yanma408\"}"))
                .andExpect(status().isOk())
                .andReturn()
                .getResponse()
                .getContentAsString();
        var token = com.jayway.jsonpath.JsonPath.read(loginResponse, "$.token").toString();

        mockMvc.perform(post("/auth/logout").header("Authorization", "Bearer " + token))
                .andExpect(status().isOk());

        Integer activeTokenCount = jdbcTemplate.queryForObject("""
                SELECT COUNT(*)
                FROM auth_tokens
                WHERE token_hash = ?
                  AND expires_at > CURRENT_TIMESTAMP
                """, Integer.class, sha256(token));
        assertEquals(0, activeTokenCount);
    }

    @Test
    void passwordResetUpdatesPasswordAndWritesAuditLog() throws Exception {
        var resetResponse = mockMvc.perform(post("/auth/password-reset/request")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"username\":\"demo\"}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.requested").value(true))
                .andReturn()
                .getResponse()
                .getContentAsString();
        var resetToken = com.jayway.jsonpath.JsonPath.read(resetResponse, "$.resetToken").toString();

        mockMvc.perform(post("/auth/password-reset/confirm")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "token": "%s",
                                  "newPassword": "newpass408"
                                }
                                """.formatted(resetToken)))
                .andExpect(status().isOk());

        mockMvc.perform(post("/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"username\":\"demo\",\"password\":\"newpass408\"}"))
                .andExpect(status().isOk());

        Integer auditCount = jdbcTemplate.queryForObject("""
                SELECT COUNT(*)
                FROM auth_audit_logs
                WHERE event_type = 'PASSWORD_RESET_CONFIRM'
                  AND success = TRUE
                """, Integer.class);
        assertEquals(1, auditCount);
    }

    @Test
    void loginRateLimitBlocksRepeatedFailures() throws Exception {
        for (int index = 0; index < 5; index++) {
            mockMvc.perform(post("/auth/login")
                            .contentType(MediaType.APPLICATION_JSON)
                            .content("{\"username\":\"missing_lock\",\"password\":\"wrongpass408\"}"))
                    .andExpect(status().isUnauthorized());
        }

        mockMvc.perform(post("/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"username\":\"missing_lock\",\"password\":\"wrongpass408\"}"))
                .andExpect(status().isUnauthorized())
                .andExpect(jsonPath("$.message").value("Too many failed login attempts. Please try again later."));
    }

    @Test
    void tokenManagementListsAndRevokesTokenById() throws Exception {
        var loginResponse = mockMvc.perform(post("/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"username\":\"demo\",\"password\":\"yanma408\"}"))
                .andExpect(status().isOk())
                .andReturn()
                .getResponse()
                .getContentAsString();
        var token = com.jayway.jsonpath.JsonPath.read(loginResponse, "$.token").toString();

        var tokensResponse = mockMvc.perform(get("/auth/tokens").header("Authorization", "Bearer " + token))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$", hasSize(1)))
                .andExpect(jsonPath("$[0].active").value(true))
                .andReturn()
                .getResponse()
                .getContentAsString();
        var tokenId = com.jayway.jsonpath.JsonPath.read(tokensResponse, "$[0].id").toString();

        mockMvc.perform(patch("/auth/tokens/{id}/revoke", tokenId).header("Authorization", "Bearer " + token))
                .andExpect(status().isOk());

        Integer activeTokenCount = jdbcTemplate.queryForObject("""
                SELECT COUNT(*)
                FROM auth_tokens
                WHERE id = ?
                  AND revoked_at IS NULL
                  AND expires_at > CURRENT_TIMESTAMP
                """, Integer.class, UUID.fromString(tokenId));
        assertEquals(0, activeTokenCount);
    }

    @Test
    void studyNotificationsCanBeDispatchedListedAndMarkedRead() throws Exception {
        mockMvc.perform(put("/study/notifications/preferences/EMAIL")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"enabled\":true,\"target\":\"demo@example.com\"}"))
                .andExpect(status().isOk());

        mockMvc.perform(get("/study/notifications/preferences"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$", hasSize(3)))
                .andExpect(jsonPath("$[2].channel").value("EMAIL"))
                .andExpect(jsonPath("$[2].enabled").value(true));

        mockMvc.perform(post("/study/tasks")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "title": "到点学习提醒",
                                  "subjectCode": "DATA_STRUCTURE",
                                  "taskType": "CUSTOM",
                                  "targetCount": 3,
                                  "estimatedMinutes": 10,
                                  "priority": "NORMAL",
                                  "reminderTime": "00:00"
                                }
                                """))
                .andExpect(status().isOk());

        mockMvc.perform(post("/study/notifications/dispatch"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.createdCount").value(2));

        var notifications = mockMvc.perform(get("/study/notifications").param("unreadOnly", "true"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$", hasSize(2)))
                .andExpect(jsonPath("$[0].content").value("到点学习提醒"))
                .andExpect(jsonPath("$[0].read").value(false))
                .andReturn()
                .getResponse()
                .getContentAsString();
        java.util.List<String> notificationIds = com.jayway.jsonpath.JsonPath.read(notifications, "$[*].id");

        for (String notificationId : notificationIds) {
            mockMvc.perform(patch("/study/notifications/{id}/read", notificationId))
                    .andExpect(status().isOk());
        }

        mockMvc.perform(get("/study/notifications").param("unreadOnly", "true"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$", hasSize(0)));
    }

    @Test
    void examReportOverviewAndMistakeBackfillWork() throws Exception {
        var firstAttemptId = startExamAttempt();
        submitExamAttempt(firstAttemptId, "B", "A")
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.accuracyPercent").value(50));

        var secondAttemptId = startExamAttempt();
        submitExamAttempt(secondAttemptId, "A", "A")
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.accuracyPercent").value(0));

        mockMvc.perform(get("/exams/reports/overview"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.attemptCount").value(2))
                .andExpect(jsonPath("$.averageAccuracyPercent").value(25))
                .andExpect(jsonPath("$.trend", hasSize(2)))
                .andExpect(jsonPath("$.weakQuestions", hasSize(2)));

        mockMvc.perform(post("/exams/attempts/{id}/mistakes/backfill", firstAttemptId))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.createdCount").value(1));

        mockMvc.perform(post("/exams/attempts/{id}/mistakes/backfill", firstAttemptId))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.createdCount").value(0));

        mockMvc.perform(get("/mistakes"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$", hasSize(2)));
    }

    private String statusForTask(String tasksJson, String title) {
        List<String> statuses = com.jayway.jsonpath.JsonPath.read(
                tasksJson,
                "$[?(@.title == '" + title + "')].status"
        );
        return statuses.get(0);
    }

    private String startExamAttempt() throws Exception {
        var startResponse = mockMvc.perform(post("/exams/00000000-0000-0000-0000-000000000801/attempts"))
                .andExpect(status().isOk())
                .andReturn()
                .getResponse()
                .getContentAsString();
        return com.jayway.jsonpath.JsonPath.read(startResponse, "$.id").toString();
    }

    private org.springframework.test.web.servlet.ResultActions submitExamAttempt(
            String attemptId,
            String firstAnswer,
            String secondAnswer
    ) throws Exception {
        return mockMvc.perform(post("/exams/attempts/{id}/submit", attemptId)
                .contentType(MediaType.APPLICATION_JSON)
                .content("""
                        {
                          "durationSeconds": 120,
                          "answers": {
                            "00000000-0000-0000-0000-000000000401": "%s",
                            "00000000-0000-0000-0000-000000000402": "%s"
                          }
                        }
                        """.formatted(firstAnswer, secondAnswer)));
    }

    private String sha256(String token) throws Exception {
        return HexFormat.of().formatHex(MessageDigest.getInstance("SHA-256").digest(token.getBytes(StandardCharsets.UTF_8)));
    }
}
