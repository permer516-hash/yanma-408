package com.yanma408;

import com.yanma408.workbench.application.material.MaterialAsset;
import com.yanma408.workbench.application.material.MaterialAssetRepository;
import com.yanma408.workbench.application.material.MaterialAssetSearchFilter;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.io.TempDir;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.apache.pdfbox.pdmodel.font.Standard14Fonts;
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
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.charset.StandardCharsets;
import java.util.HexFormat;
import java.time.Instant;

import static org.hamcrest.Matchers.containsInAnyOrder;
import static org.hamcrest.Matchers.containsString;
import static org.hamcrest.Matchers.greaterThanOrEqualTo;
import static org.hamcrest.Matchers.hasItems;
import static org.hamcrest.Matchers.hasSize;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;
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
    private static final UUID TEACHER_USER_ID = UUID.fromString("00000000-0000-0000-0000-000000000901");
    private static final UUID SECOND_TEACHER_USER_ID = UUID.fromString("00000000-0000-0000-0000-000000000902");
    private static final UUID EXTRA_STUDENT_USER_ID = UUID.fromString("00000000-0000-0000-0000-000000000903");
    private static final UUID QUESTION_ID = UUID.fromString("00000000-0000-0000-0000-000000000401");
    private static final UUID ATTEMPT_ID = UUID.fromString("10000000-0000-0000-0000-000000000001");
    private static final UUID MISTAKE_ID = UUID.fromString("20000000-0000-0000-0000-000000000001");
    private static final UUID STUDY_TASK_ID = UUID.fromString("00000000-0000-0000-0000-000000000702");
    private static final UUID DEFAULT_CLASS_ID = UUID.fromString("00000000-0000-0000-0000-000000001701");

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Autowired
    private MaterialAssetRepository materialAssetRepository;

    @TempDir
    Path tempDir;

    @BeforeEach
    void setUp() {
        jdbcTemplate.update("DELETE FROM mistakes");
        jdbcTemplate.update("DELETE FROM practice_attempts");
        jdbcTemplate.update("DELETE FROM exam_attempt_answers");
        jdbcTemplate.update("DELETE FROM exam_attempts");
        jdbcTemplate.update("DELETE FROM study_notifications");
        jdbcTemplate.update("DELETE FROM study_task_occurrences");
        jdbcTemplate.update("DELETE FROM study_plan_tasks");
        jdbcTemplate.update("DELETE FROM teacher_task_assignments");
        jdbcTemplate.update("DELETE FROM teacher_class_students");
        jdbcTemplate.update("DELETE FROM teacher_classes");
        jdbcTemplate.update("DELETE FROM auth_audit_logs");
        jdbcTemplate.update("DELETE FROM auth_tokens");
        jdbcTemplate.update("DELETE FROM app_users WHERE username LIKE 'registration-rate-%'");
        jdbcTemplate.update("DELETE FROM question_text_vectors");
        jdbcTemplate.update("DELETE FROM question_draft_references");
        jdbcTemplate.update("DELETE FROM question_draft_review_tasks");
        jdbcTemplate.update("DELETE FROM question_draft_tags");
        jdbcTemplate.update("DELETE FROM question_draft_knowledge_points");
        jdbcTemplate.update("DELETE FROM question_draft_options");
        jdbcTemplate.update("DELETE FROM question_drafts");
        jdbcTemplate.update("DELETE FROM material_authorization_attachments");
        jdbcTemplate.update("DELETE FROM material_extraction_candidates");
        jdbcTemplate.update("DELETE FROM material_copyright_audits");
        jdbcTemplate.update("DELETE FROM material_assets");
        jdbcTemplate.update("DELETE FROM question_feedbacks");
        jdbcTemplate.update("DELETE FROM question_tag_relations");
        jdbcTemplate.update("DELETE FROM question_tags");
        jdbcTemplate.update("""
                DELETE FROM app_user_roles
                WHERE user_id IN (?, ?, ?)
                """, TEACHER_USER_ID, SECOND_TEACHER_USER_ID, EXTRA_STUDENT_USER_ID);
        jdbcTemplate.update("""
                DELETE FROM app_users
                WHERE id IN (?, ?, ?)
                """, TEACHER_USER_ID, SECOND_TEACHER_USER_ID, EXTRA_STUDENT_USER_ID);
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
                INSERT INTO teacher_classes (
                    id, teacher_id, name, course_name, description, status, created_at, updated_at
                )
                VALUES (?, ?, '默认 408 班级', '408 综合', 'MVP 默认班级', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
                """, DEFAULT_CLASS_ID, DEV_USER_ID);
        jdbcTemplate.update("""
                INSERT INTO teacher_class_students (class_id, student_id, created_at)
                VALUES (?, ?, CURRENT_TIMESTAMP)
                """, DEFAULT_CLASS_ID, DEV_USER_ID);
        jdbcTemplate.update("""
                INSERT INTO app_users (id, username, display_name, password_hash, created_at, updated_at)
                VALUES
                (?, 'teacher-a', '王老师', '{noop}yanma408', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
                (?, 'teacher-b', '李老师', '{noop}yanma408', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
                (?, 'student-extra', '绑定学生', '{noop}yanma408', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
                """, TEACHER_USER_ID, SECOND_TEACHER_USER_ID, EXTRA_STUDENT_USER_ID);
        jdbcTemplate.update("""
                INSERT INTO app_user_roles (user_id, role, created_at)
                VALUES
                (?, 'TEACHER', CURRENT_TIMESTAMP),
                (?, 'TEACHER', CURRENT_TIMESTAMP),
                (?, 'STUDENT', CURRENT_TIMESTAMP)
                """, TEACHER_USER_ID, SECOND_TEACHER_USER_ID, EXTRA_STUDENT_USER_ID);
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
    void teacherCanViewStudentLearningOverviewAndDetail() throws Exception {
        mockMvc.perform(get("/teacher/students"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].id").value(DEV_USER_ID.toString()))
                .andExpect(jsonPath("$[0].attemptCount").value(1))
                .andExpect(jsonPath("$[0].mistakeCount").value(1))
                .andExpect(jsonPath("$[0].masteredMistakeCount").value(1));

        mockMvc.perform(get("/teacher/students/{studentId}", DEV_USER_ID))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.summary.id").value(DEV_USER_ID.toString()))
                .andExpect(jsonPath("$.dashboard.weeklyAccuracy.attemptCount").value(1))
                .andExpect(jsonPath("$.recentMistakes", hasSize(1)))
                .andExpect(jsonPath("$.recentMistakes[0].id").value(MISTAKE_ID.toString()));
    }

    @Test
    void roleModelOnlyAllowsAdminTeacherAndStudent() {
        var roles = jdbcTemplate.queryForList("""
                SELECT DISTINCT role
                FROM app_user_roles
                ORDER BY role
                """, String.class);

        assertEquals(List.of("ADMIN", "STUDENT", "TEACHER"), roles);
    }

    @Test
    void adminCanCreateTeacherWithoutRootRole() throws Exception {
        mockMvc.perform(post("/auth/teachers")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "username": "teacher-created-by-admin",
                                  "displayName": "管理员创建老师",
                                  "password": "yanma408"
                                }
                                """))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.username").value("teacher-created-by-admin"))
                .andExpect(jsonPath("$.roles", containsInAnyOrder("TEACHER")));
    }

    @Test
    void teacherCanManageClassAssignTaskAndExportStudentReport() throws Exception {
        var createdClassResponse = mockMvc.perform(post("/teacher/classes")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "name": "408 冲刺班",
                                  "courseName": "408 综合",
                                  "description": "测试班级"
                                }
                                """))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.name").value("408 冲刺班"))
                .andExpect(jsonPath("$.studentCount").value(0))
                .andReturn()
                .getResponse()
                .getContentAsString();
        var classId = com.jayway.jsonpath.JsonPath.read(createdClassResponse, "$.id").toString();

        mockMvc.perform(post("/teacher/classes/{classId}/students", classId)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "studentIds": ["00000000-0000-0000-0000-000000000001"]
                                }
                                """))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.studentCount").value(1));

        mockMvc.perform(get("/teacher/students").param("classId", classId))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$", hasSize(1)))
                .andExpect(jsonPath("$[0].id").value(DEV_USER_ID.toString()));

        mockMvc.perform(post("/teacher/classes/{classId}/assignments", classId)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "title": "教师下发网络层练习",
                                  "subjectCode": "COMPUTER_NETWORK",
                                  "taskType": "QUESTION_SET",
                                  "targetCount": 12,
                                  "estimatedMinutes": 20,
                                  "priority": "IMPORTANT",
                                  "taskDate": "2026-05-18",
                                  "recurrenceRule": "NONE",
                                  "reminderTime": "20:00"
                                }
                                """))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.title").value("教师下发网络层练习"))
                .andExpect(jsonPath("$.assignedCount").value(1));

        mockMvc.perform(get("/teacher/classes/{classId}/assignments", classId))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].title").value("教师下发网络层练习"));

        var taskPayload = mockMvc.perform(get("/study/tasks").param("date", "2026-05-18"))
                .andExpect(status().isOk())
                .andReturn()
                .getResponse()
                .getContentAsString();
        assertTrue(taskPayload.contains("教师下发网络层练习"));

        var csv = mockMvc.perform(get("/teacher/students/export.csv").param("classId", classId))
                .andExpect(status().isOk())
                .andReturn()
                .getResponse()
                .getContentAsString(StandardCharsets.UTF_8);
        assertTrue(csv.contains("学生ID,用户名,昵称"));
        assertTrue(csv.contains(DEV_USER_ID.toString()));
    }

    @Test
    @WithMockUser(username = "00000000-0000-0000-0000-000000000901")
    void teacherCannotBindStudentsOrListGlobalStudentCandidates() throws Exception {
        var classId = UUID.fromString("00000000-0000-0000-0000-000000009101");
        jdbcTemplate.update("""
                INSERT INTO teacher_classes (
                    id, teacher_id, name, course_name, description, status, created_at, updated_at
                )
                VALUES (?, ?, '王老师班级', '408 综合', '测试', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
                """, classId, TEACHER_USER_ID);

        mockMvc.perform(get("/teacher/students/candidates"))
                .andExpect(status().isForbidden());

        mockMvc.perform(get("/teacher/teachers"))
                .andExpect(status().isForbidden());

        mockMvc.perform(post("/teacher/classes/{classId}/students", classId)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "studentIds": ["00000000-0000-0000-0000-000000000903"]
                                }
                                """))
                .andExpect(status().isForbidden());

        mockMvc.perform(delete("/teacher/classes/{classId}/students/{studentId}", classId, EXTRA_STUDENT_USER_ID))
                .andExpect(status().isForbidden());
    }

    @Test
    void adminCanCreateTeacherClassesAndBindOneStudentToMultipleTeachers() throws Exception {
        mockMvc.perform(get("/teacher/teachers"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[*].id", hasItems(
                        DEV_USER_ID.toString(),
                        TEACHER_USER_ID.toString(),
                        SECOND_TEACHER_USER_ID.toString()
                )));

        var firstClassResponse = mockMvc.perform(post("/teacher/classes")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "teacherId": "00000000-0000-0000-0000-000000000901",
                                  "name": "王老师 408 班",
                                  "courseName": "408 综合",
                                  "description": "管理员创建"
                                }
                                """))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.teacherId").value(TEACHER_USER_ID.toString()))
                .andExpect(jsonPath("$.teacherDisplayName").value("王老师"))
                .andReturn()
                .getResponse()
                .getContentAsString();
        var firstClassId = com.jayway.jsonpath.JsonPath.read(firstClassResponse, "$.id").toString();

        var secondClassResponse = mockMvc.perform(post("/teacher/classes")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "teacherId": "00000000-0000-0000-0000-000000000902",
                                  "name": "李老师 408 班",
                                  "courseName": "408 综合",
                                  "description": "管理员创建"
                                }
                                """))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.teacherId").value(SECOND_TEACHER_USER_ID.toString()))
                .andReturn()
                .getResponse()
                .getContentAsString();
        var secondClassId = com.jayway.jsonpath.JsonPath.read(secondClassResponse, "$.id").toString();

        for (String classId : List.of(firstClassId, secondClassId)) {
            mockMvc.perform(post("/teacher/classes/{classId}/students", classId)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content("""
                                    {
                                      "studentIds": ["00000000-0000-0000-0000-000000000903"]
                                    }
                                    """))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.studentCount").value(1));
        }

        mockMvc.perform(get("/teacher/students").param("classId", firstClassId))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$", hasSize(1)))
                .andExpect(jsonPath("$[0].id").value(EXTRA_STUDENT_USER_ID.toString()));

        mockMvc.perform(get("/teacher/classes"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[*].teacherId", containsInAnyOrder(
                        DEV_USER_ID.toString(),
                        TEACHER_USER_ID.toString(),
                        SECOND_TEACHER_USER_ID.toString()
                )));
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
                .andExpect(jsonPath("$.items", hasSize(1)))
                .andExpect(jsonPath("$.page").value(0))
                .andExpect(jsonPath("$.size").value(30))
                .andExpect(jsonPath("$.total").value(1))
                .andExpect(jsonPath("$.items[0].stem").value("在时间片轮转调度中，时间片过大时算法退化为哪类调度？"));
    }

    @Test
    void studentCanSubmitQuestionFeedbackForAdminReview() throws Exception {
        mockMvc.perform(post("/questions/{id}/feedback", QUESTION_ID)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "issueType": "ANSWER_INCORRECT",
                                  "description": "我觉得正确答案和解析不一致"
                                }
                                """))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.questionId").value(QUESTION_ID.toString()))
                .andExpect(jsonPath("$.issueType").value("ANSWER_INCORRECT"))
                .andExpect(jsonPath("$.description").value("我觉得正确答案和解析不一致"))
                .andExpect(jsonPath("$.status").value("PENDING"))
                .andExpect(jsonPath("$.reporterDisplayName").value("研码同学"))
                .andExpect(jsonPath("$.questionStem", containsString("二叉树")));

        mockMvc.perform(get("/admin/question-feedbacks")
                        .param("status", "PENDING")
                        .param("issueType", "ANSWER_INCORRECT"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.items", hasSize(1)))
                .andExpect(jsonPath("$.items[0].questionId").value(QUESTION_ID.toString()))
                .andExpect(jsonPath("$.items[0].reporterDisplayName").value("研码同学"))
                .andExpect(jsonPath("$.items[0].status").value("PENDING"))
                .andExpect(jsonPath("$.total").value(1));
    }

    @Test
    void adminCanMarkQuestionFeedbackHandled() throws Exception {
        var feedbackResponse = mockMvc.perform(post("/questions/{id}/feedback", QUESTION_ID)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "issueType": "EXPLANATION_UNCLEAR",
                                  "description": "解析步骤太跳跃"
                                }
                                """))
                .andExpect(status().isOk())
                .andReturn()
                .getResponse()
                .getContentAsString();
        var feedbackId = com.jayway.jsonpath.JsonPath.read(feedbackResponse, "$.id").toString();

        mockMvc.perform(patch("/admin/question-feedbacks/{id}/status", feedbackId)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "status": "RESOLVED",
                                  "adminNote": "已修正解析"
                                }
                                """))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.status").value("RESOLVED"))
                .andExpect(jsonPath("$.adminNote").value("已修正解析"))
                .andExpect(jsonPath("$.handledByDisplayName").value("研码同学"));

        mockMvc.perform(get("/admin/question-feedbacks").param("status", "RESOLVED"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.items", hasSize(1)))
                .andExpect(jsonPath("$.items[0].id").value(feedbackId));
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
                .andExpect(jsonPath("$.items[0].status").value("DELETED"));
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
                .andExpect(jsonPath("$.items[0].reviewStatus").value("REJECTED"))
                .andExpect(jsonPath("$.items[0].tags", containsInAnyOrder("需重审", "408")));
    }

    @Test
    void adminQuestionListFiltersByShelfAndReviewStatus() throws Exception {
        mockMvc.perform(patch("/admin/questions/{id}/status", QUESTION_ID)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"status\":\"DRAFT\"}"))
                .andExpect(status().isOk());
        mockMvc.perform(patch("/admin/questions/{id}/review", QUESTION_ID)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"reviewStatus\":\"REJECTED\",\"reviewNote\":\"答案需核对\"}"))
                .andExpect(status().isOk());

        mockMvc.perform(get("/admin/questions")
                        .param("subject", "DATA_STRUCTURE")
                        .param("status", "DRAFT")
                        .param("reviewStatus", "REJECTED"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.items", hasSize(1)))
                .andExpect(jsonPath("$.total").value(1))
                .andExpect(jsonPath("$.items[0].id").value(QUESTION_ID.toString()))
                .andExpect(jsonPath("$.items[0].status").value("DRAFT"))
                .andExpect(jsonPath("$.items[0].reviewStatus").value("REJECTED"));

        mockMvc.perform(get("/admin/questions")
                        .param("status", "DRAFT")
                        .param("reviewStatus", "APPROVED"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.items", hasSize(0)))
                .andExpect(jsonPath("$.total").value(0));
    }

    @Test
    void adminQuestionListFiltersByDifficultyAndSource() throws Exception {
        jdbcTemplate.update("""
                UPDATE questions
                SET difficulty = 'HARD',
                    source = 'PAST_EXAM'
                WHERE id = ?
                """, QUESTION_ID);

        mockMvc.perform(get("/admin/questions")
                        .param("subject", "DATA_STRUCTURE")
                        .param("difficulty", "HARD")
                        .param("source", "PAST_EXAM"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.items", hasSize(1)))
                .andExpect(jsonPath("$.total").value(1))
                .andExpect(jsonPath("$.items[0].id").value(QUESTION_ID.toString()))
                .andExpect(jsonPath("$.items[0].difficulty").value("HARD"))
                .andExpect(jsonPath("$.items[0].source").value("PAST_EXAM"));

        mockMvc.perform(get("/admin/questions")
                        .param("subject", "DATA_STRUCTURE")
                        .param("difficulty", "BASIC")
                        .param("source", "PAST_EXAM"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.items", hasSize(0)))
                .andExpect(jsonPath("$.total").value(0));

        mockMvc.perform(get("/admin/questions")
                        .param("subject", "DATA_STRUCTURE")
                        .param("difficulty", "HARD")
                        .param("source", "ORIGINAL"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.items", hasSize(0)))
                .andExpect(jsonPath("$.total").value(0));
    }

    @Test
    void adminQuestionListFiltersByKeywordAndExistingFilters() throws Exception {
        jdbcTemplate.update("""
                UPDATE questions
                SET difficulty = 'HARD',
                    source = 'PAST_EXAM',
                    stem = '哈夫曼树编码测试题',
                    explanation = '用于验证后台关键词搜索'
                WHERE id = ?
                """, QUESTION_ID);

        mockMvc.perform(get("/admin/questions")
                        .param("subject", "DATA_STRUCTURE")
                        .param("difficulty", "HARD")
                        .param("source", "PAST_EXAM")
                        .param("keyword", "哈夫曼树"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.items", hasSize(1)))
                .andExpect(jsonPath("$.total").value(1))
                .andExpect(jsonPath("$.items[0].id").value(QUESTION_ID.toString()));

        mockMvc.perform(get("/admin/questions")
                        .param("subject", "DATA_STRUCTURE")
                        .param("difficulty", "HARD")
                        .param("source", "PAST_EXAM")
                        .param("keyword", "后台关键词搜索"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.items", hasSize(1)))
                .andExpect(jsonPath("$.total").value(1))
                .andExpect(jsonPath("$.items[0].id").value(QUESTION_ID.toString()));

        mockMvc.perform(get("/admin/questions")
                        .param("subject", "DATA_STRUCTURE")
                        .param("difficulty", "HARD")
                        .param("source", "PAST_EXAM")
                        .param("keyword", "不存在的题目内容"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.items", hasSize(0)))
                .andExpect(jsonPath("$.total").value(0));
    }

    @Test
    void adminQuestionListSupportsPaginationMetadata() throws Exception {
        mockMvc.perform(get("/admin/questions")
                        .param("page", "0")
                        .param("size", "1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.items", hasSize(1)))
                .andExpect(jsonPath("$.page").value(0))
                .andExpect(jsonPath("$.size").value(1))
                .andExpect(jsonPath("$.total", greaterThanOrEqualTo(2)))
                .andExpect(jsonPath("$.totalPages", greaterThanOrEqualTo(2)));

        mockMvc.perform(get("/admin/questions")
                        .param("page", "1")
                        .param("size", "1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.items", hasSize(1)))
                .andExpect(jsonPath("$.page").value(1))
                .andExpect(jsonPath("$.size").value(1));
    }

    @Test
    void adminCanUpdateQuestionInlineAttributes() throws Exception {
        mockMvc.perform(patch("/admin/questions/{id}/difficulty", QUESTION_ID)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"difficulty\":\"HARD\"}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.difficulty").value("HARD"));

        mockMvc.perform(patch("/admin/questions/{id}/difficulty", QUESTION_ID)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"difficulty\":\"UNKNOWN\"}"))
                .andExpect(status().isBadRequest());

        mockMvc.perform(patch("/admin/questions/{id}/source", QUESTION_ID)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"source\":\"MOCK\"}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.source").value("MOCK"));

        mockMvc.perform(patch("/admin/questions/{id}/source", QUESTION_ID)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"source\":\"UNKNOWN\"}"))
                .andExpect(status().isBadRequest());
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
                DATA_STRUCTURE,DS_TREE,SINGLE_CHOICE,BASIC,CSV导入题,A,CSV解析,模拟题,2,正确,错误,DS_TREE_TRAVERSAL
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
                .andExpect(jsonPath("$[0].stem").value("CSV导入题"))
                .andExpect(jsonPath("$[0].source").value("MOCK"));
    }

    @Test
    void questionSearchSupportsFiltersAndPagination() throws Exception {
        mockMvc.perform(get("/questions/search")
                        .param("keyword", "二叉树")
                        .param("difficulty", "BASIC")
                        .param("source", "ORIGINAL")
                        .param("knowledgePoint", "DS_TREE_TRAVERSAL")
                        .param("page", "0")
                        .param("size", "1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.total").value(1))
                .andExpect(jsonPath("$.totalPages").value(1))
                .andExpect(jsonPath("$.items", hasSize(1)))
                .andExpect(jsonPath("$.items[0].id").value(QUESTION_ID.toString()))
                .andExpect(jsonPath("$.items[0].source").value("ORIGINAL"));
    }

    @Test
    void pastExamQuestionRequiresSourceYear() throws Exception {
        mockMvc.perform(post("/questions")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "subjectCode": "DATA_STRUCTURE",
                                  "chapterCode": "DS_TREE",
                                  "type": "SINGLE_CHOICE",
                                  "difficulty": "BASIC",
                                  "stem": "某年真题缺少年份时不应入库",
                                  "answer": "A",
                                  "explanation": "真题需要保留明确年份，方便版权审计和训练路径组织。",
                                  "source": "PAST_EXAM",
                                  "score": 2,
                                  "options": [
                                    {"label": "A", "content": "正确"},
                                    {"label": "B", "content": "错误"}
                                  ],
                                  "knowledgePointCodes": ["DS_TREE_TRAVERSAL"]
                                }
                                """))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.code").value("BAD_REQUEST"));
    }

    @Test
    void materialAssetRepositoryPersistsObjectStorageMetadata() {
        var now = Instant.now();
        var asset = new MaterialAsset(
                UUID.fromString("30000000-0000-0000-0000-000000000001"),
                "2026 数据结构资料",
                "DATA_STRUCTURE",
                "TEXTBOOK",
                2026,
                "yanma408-materials",
                "raw/textbook/2026/data-structure.pdf",
                "data-structure.pdf",
                "application/pdf",
                128,
                "0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef",
                "REGISTERED",
                "仓储冒烟测试",
                now,
                now
        );

        materialAssetRepository.save(asset);

        var results = materialAssetRepository.search(new MaterialAssetSearchFilter("数据结构", "DATA_STRUCTURE", "TEXTBOOK", "REGISTERED"));
        assertEquals(1, results.size());
        assertEquals(asset.objectKey(), results.get(0).objectKey());
        assertEquals(asset.sha256(), results.get(0).sha256());
    }

    @Test
    void workbenchContentPipelineSupportsQuotaDraftReviewAndPublish() throws Exception {
        mockMvc.perform(get("/workbench/content-quotas"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$", hasSize(12)))
                .andExpect(jsonPath("$[0].targetCount").exists())
                .andExpect(jsonPath("$[0].remainingCount").exists());

        var createResponse = mockMvc.perform(post("/workbench/question-drafts")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "subjectCode": "OPERATING_SYSTEM",
                                  "chapterCode": "OS_PROCESS",
                                  "type": "SINGLE_CHOICE",
                                  "difficulty": "BASIC",
                                  "stem": "当采用非抢占式调度时，正在运行的进程通常在什么情况下让出处理机？",
                                  "answer": "A",
                                  "explanation": "非抢占式调度下，运行进程通常在完成、阻塞或主动放弃处理机时才让出 CPU。",
                                  "source": "ORIGINAL",
                                  "score": 2,
                                  "options": [
                                    {"label": "A", "content": "进程完成或阻塞时"},
                                    {"label": "B", "content": "任意高优先级进程到达时"},
                                    {"label": "C", "content": "每经过一个固定时间片时"},
                                    {"label": "D", "content": "系统时钟每次中断时"}
                                  ],
                                  "knowledgePointCodes": ["OS_SCHEDULING"],
                                  "tags": ["工作台草稿", "原创题"]
                                }
                                """))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.status").value("DRAFT"))
                .andExpect(jsonPath("$.reviewStatus").value("PENDING"))
                .andReturn()
                .getResponse()
                .getContentAsString();
        var draftId = com.jayway.jsonpath.JsonPath.read(createResponse, "$.id").toString();

        mockMvc.perform(get("/workbench/question-drafts/{id}/duplicates", draftId))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.duplicate").value(false));

        mockMvc.perform(post("/workbench/question-drafts/{id}/submit-review", draftId))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.status").value("REVIEWING"));

        mockMvc.perform(patch("/workbench/question-drafts/{id}/review", draftId)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "reviewStatus": "APPROVED",
                                  "reviewNote": "首批原创题审核通过",
                                  "reviewerRole": "ADMIN"
                                }
                                """))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.status").value("APPROVED"))
                .andExpect(jsonPath("$.reviewStatus").value("APPROVED"));

        mockMvc.perform(post("/workbench/question-drafts/{id}/publish", draftId))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.status").value("PUBLISHED"))
                .andExpect(jsonPath("$.publishedQuestionId").exists());

        mockMvc.perform(get("/questions/search")
                        .param("keyword", "非抢占式调度")
                        .param("source", "ORIGINAL"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.total").value(1))
                .andExpect(jsonPath("$.items[0].reviewStatus").value("APPROVED"));
    }

    @Test
    void workbenchExtractsPdfCandidatesAndStoresPageReferences() throws Exception {
        var pdf = tempDir.resolve("cache-sample.pdf");
        try (var document = new PDDocument()) {
            var page = new PDPage();
            document.addPage(page);
            try (var content = new PDPageContentStream(document, page)) {
                content.beginText();
                content.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA), 12);
                content.newLineAtOffset(50, 700);
                content.showText("Cache direct mapping question choose the correct cache line.");
                content.endText();
            }
            document.save(pdf.toFile());
        }

        var now = Instant.now();
        var assetId = UUID.fromString("30000000-0000-0000-0000-000000000003");
        materialAssetRepository.save(new MaterialAsset(
                assetId,
                "Cache PDF 样本",
                "COMPUTER_ORGANIZATION",
                "MOCK_EXAM",
                2026,
                "LOCAL",
                pdf.toString(),
                "cache-sample.pdf",
                "application/pdf",
                Files.size(pdf),
                sha256(Files.readString(pdf, StandardCharsets.ISO_8859_1)),
                "REGISTERED",
                "PDF 拆题测试",
                now,
                now
        ));

        var extractResponse = mockMvc.perform(post("/workbench/materials/{id}/extract-candidates", assetId)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"startPage\":1,\"endPage\":1}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$", hasSize(1)))
                .andExpect(jsonPath("$[0].pageNumber").value(1))
                .andExpect(jsonPath("$[0].status").value("EXTRACTED"))
                .andExpect(jsonPath("$[0].suggestedStem", containsString("Cache direct mapping question")))
                .andReturn()
                .getResponse()
                .getContentAsString();
        var candidateId = com.jayway.jsonpath.JsonPath.read(extractResponse, "$[0].id").toString();

        mockMvc.perform(post("/workbench/question-drafts")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "materialAssetId": "%s",
                                  "subjectCode": "COMPUTER_ORGANIZATION",
                                  "chapterCode": "CO_CACHE",
                                  "type": "SINGLE_CHOICE",
                                  "difficulty": "MEDIUM",
                                  "stem": "直接映射 Cache 中，主存块号应根据哪一类信息确定可放入的 Cache 行？",
                                  "answer": "A",
                                  "explanation": "直接映射中 Cache 行号由主存块号对 Cache 行数取模得到。",
                                  "source": "MOCK",
                                  "sourceYear": 2026,
                                  "score": 2,
                                  "options": [
                                    {"label": "A", "content": "主存块号与 Cache 行数的取模结果"},
                                    {"label": "B", "content": "主存块内地址的最低位"},
                                    {"label": "C", "content": "标记字段的最高位"},
                                    {"label": "D", "content": "替换算法选择的空闲行"}
                                  ],
                                  "knowledgePointCodes": ["CO_CACHE_MAPPING"],
                                  "tags": ["PDF拆题", "模拟题"],
                                  "pageReferences": [
                                    {
                                      "materialAssetId": "%s",
                                      "extractionCandidateId": "%s",
                                      "pageNumber": 1,
                                      "quote": "Cache direct mapping question",
                                      "referenceNote": "PDF page 1"
                                    }
                                  ]
                                }
                                """.formatted(assetId, assetId, candidateId)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.pageReferences", hasSize(1)))
                .andExpect(jsonPath("$.pageReferences[0].pageNumber").value(1))
                .andExpect(jsonPath("$.pageReferences[0].quote").value("Cache direct mapping question"));
    }

    @Test
    void workbenchReviewsCandidatesAndBatchCreatesSubjectiveDrafts() throws Exception {
        var pdf = tempDir.resolve("subjective-sample.pdf");
        try (var document = new PDDocument()) {
            var page = new PDPage();
            document.addPage(page);
            document.save(pdf.toFile());
        }

        var now = Instant.now();
        var assetId = UUID.fromString("30000000-0000-0000-0000-000000000004");
        materialAssetRepository.save(new MaterialAsset(
                assetId,
                "主观题 PDF 样本",
                "OPERATING_SYSTEM",
                "MOCK_EXAM",
                2026,
                "LOCAL",
                pdf.toString(),
                "subjective-sample.pdf",
                "application/pdf",
                Files.size(pdf),
                sha256(Files.readString(pdf, StandardCharsets.ISO_8859_1)),
                "REGISTERED",
                "OCR 和人工校对测试",
                now,
                now
        ));

        var extractResponse = mockMvc.perform(post("/workbench/materials/{id}/extract-candidates", assetId)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"startPage\":1,\"endPage\":1}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].status").value("OCR_REQUIRED"))
                .andReturn()
                .getResponse()
                .getContentAsString();
        var candidateId = com.jayway.jsonpath.JsonPath.read(extractResponse, "$[0].id").toString();

        mockMvc.perform(post("/workbench/extraction-candidates/{id}/run-ocr", candidateId)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "ocrTextOverride": "说明进程调度中响应比优先算法的基本思想。"
                                }
                                """))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.status").value("OCR_DONE"))
                .andExpect(jsonPath("$.ocrText").value("说明进程调度中响应比优先算法的基本思想。"));

        mockMvc.perform(patch("/workbench/extraction-candidates/{id}/review", candidateId)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "type": "COMPREHENSIVE",
                                  "stem": "说明高响应比优先调度算法的响应比公式，并解释它如何兼顾短作业和等待时间较长的作业。",
                                  "answer": "参考答案见解析",
                                  "explanation": "响应比 = (等待时间 + 服务时间) / 服务时间。等待越久响应比越高，短作业服务时间小也容易获得较高响应比。"
                                }
                                """))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.status").value("REVIEWED"))
                .andExpect(jsonPath("$.correctedQuestionType").value("COMPREHENSIVE"));

        var batchResponse = mockMvc.perform(post("/workbench/extraction-candidates/batch-create-drafts")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "candidateIds": ["%s"],
                                  "subjectCode": "OPERATING_SYSTEM",
                                  "chapterCode": "OS_PROCESS",
                                  "difficulty": "MEDIUM",
                                  "source": "MOCK",
                                  "sourceYear": 2026,
                                  "score": 8,
                                  "knowledgePointCodes": ["OS_SCHEDULING"],
                                  "tags": ["OCR候选", "大题"]
                                }
                                """.formatted(candidateId)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.createdCount").value(1))
                .andReturn()
                .getResponse()
                .getContentAsString();
        var draftId = com.jayway.jsonpath.JsonPath.read(batchResponse, "$.drafts[0].draftId").toString();

        mockMvc.perform(get("/workbench/question-drafts/{id}", draftId))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.type").value("COMPREHENSIVE"))
                .andExpect(jsonPath("$.options", hasSize(0)))
                .andExpect(jsonPath("$.pageReferences[0].extractionCandidateId").value(candidateId));
    }

    @Test
    void adminImportSupportsSubjectiveQuestionsWithoutOptions() throws Exception {
        mockMvc.perform(post("/admin/questions/import/preview")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "questions": [
                                    {
                                      "subjectCode": "COMPUTER_NETWORK",
                                      "chapterCode": "CN_TRANSPORT",
                                      "type": "COMPREHENSIVE",
                                      "difficulty": "HARD",
                                      "stem": "简述 TCP 拥塞控制中慢开始与拥塞避免的切换条件。",
                                      "answer": "参考答案见解析",
                                      "explanation": "慢开始阶段拥塞窗口指数增长，达到慢开始门限后进入拥塞避免阶段并线性增长。",
                                      "source": "ORIGINAL",
                                      "score": 8,
                                      "options": [],
                                      "knowledgePointCodes": ["CN_TCP_CONGESTION"],
                                      "tags": ["大题", "拥塞控制"]
                                    }
                                  ]
                                }
                                """))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.validRows").value(1))
                .andExpect(jsonPath("$.invalidRows").value(0));
    }

    @Test
    void workbenchDuplicateCheckReportsTokenVectorSimilarity() throws Exception {
        var firstResponse = mockMvc.perform(post("/workbench/question-drafts")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "subjectCode": "OPERATING_SYSTEM",
                                  "chapterCode": "OS_PROCESS",
                                  "type": "COMPREHENSIVE",
                                  "difficulty": "MEDIUM",
                                  "stem": "说明分页存储管理中地址转换需要页表项的原因。",
                                  "answer": "参考答案见解析",
                                  "explanation": "页表项记录页号到物理块号的映射，地址转换必须通过它得到物理地址。",
                                  "source": "ORIGINAL",
                                  "score": 8,
                                  "options": [],
                                  "knowledgePointCodes": ["OS_SCHEDULING"],
                                  "tags": ["大题"]
                                }
                                """))
                .andExpect(status().isOk())
                .andReturn()
                .getResponse()
                .getContentAsString();

        var secondResponse = mockMvc.perform(post("/workbench/question-drafts")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "subjectCode": "OPERATING_SYSTEM",
                                  "chapterCode": "OS_PROCESS",
                                  "type": "COMPREHENSIVE",
                                  "difficulty": "MEDIUM",
                                  "stem": "说明分页存储管理中地址转换需要页表项的原因，请作答。",
                                  "answer": "参考答案见解析",
                                  "explanation": "页表项保存逻辑页与物理块之间的对应关系，查询后才能形成物理地址。",
                                  "source": "ORIGINAL",
                                  "score": 8,
                                  "options": [],
                                  "knowledgePointCodes": ["OS_SCHEDULING"],
                                  "tags": ["大题"]
                                }
                                """))
                .andExpect(status().isOk())
                .andReturn()
                .getResponse()
                .getContentAsString();
        var secondDraftId = com.jayway.jsonpath.JsonPath.read(secondResponse, "$.id").toString();

        mockMvc.perform(get("/workbench/question-drafts/{id}/duplicates", secondDraftId))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.items[0].matchType").value("TOKEN_VECTOR"));
    }

    @Test
    @WithMockUser(username = "00000000-0000-0000-0000-000000000998")
    void workbenchRbacRejectsUsersWithoutAuthorRoles() throws Exception {
        mockMvc.perform(get("/workbench/content-quotas"))
                .andExpect(status().isForbidden());
    }

    @Test
    void workbenchLocalScanRegistersMaterialMetadataOnly() throws Exception {
        var material = tempDir.resolve("2026数据结构.pdf");
        Files.writeString(material, "metadata only", StandardCharsets.UTF_8);

        mockMvc.perform(post("/workbench/materials/scan-local")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"rootPath\":\"" + material.getParent().toString().replace("\\", "\\\\") + "\"}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.scannedFiles").value(1))
                .andExpect(jsonPath("$.registeredFiles").value(1))
                .andExpect(jsonPath("$.assets[0].sourceType").value("TEXTBOOK"))
                .andExpect(jsonPath("$.assets[0].subjectCode").value("DATA_STRUCTURE"))
                .andExpect(jsonPath("$.assets[0].sourceYear").value(2026));

        mockMvc.perform(post("/workbench/materials/scan-local")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"rootPath\":\"" + material.getParent().toString().replace("\\", "\\\\") + "\"}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.scannedFiles").value(1))
                .andExpect(jsonPath("$.registeredFiles").value(0))
                .andExpect(jsonPath("$.skippedFiles").value(1));
    }

    @Test
    void copyrightAuditBlocksUnknownHighRiskApproval() throws Exception {
        var now = Instant.now();
        var assetId = UUID.fromString("30000000-0000-0000-0000-000000000002");
        materialAssetRepository.save(new MaterialAsset(
                assetId,
                "2023 真题解析",
                null,
                "PAST_EXAM",
                2023,
                "LOCAL",
                "/Users/permer/Documents/408资料/2023真题解析.pdf",
                "2023真题解析.pdf",
                "application/pdf",
                128,
                "abcdef6789abcdef0123456789abcdef0123456789abcdef0123456789abcd",
                "REGISTERED",
                "copyright audit test",
                now,
                now
        ));

        mockMvc.perform(post("/workbench/materials/{id}/copyright-audits", assetId)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "sourceName": "2023 计算机专业基础综合考试历年真题解析",
                                  "authorizationScope": "UNKNOWN",
                                  "riskLevel": "HIGH",
                                  "decision": "APPROVED_FOR_EXTRACTION",
                                  "auditedBy": "tester"
                                }
                                """))
                .andExpect(status().isBadRequest());

        mockMvc.perform(post("/workbench/materials/{id}/copyright-audits", assetId)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "sourceName": "2023 计算机专业基础综合考试历年真题解析",
                                  "authorizationScope": "INTERNAL_REFERENCE",
                                  "riskLevel": "MEDIUM",
                                  "decision": "NEEDS_PERMISSION",
                                  "notes": "仅登记资料，不抽取真题原文。",
                                  "auditedBy": "tester"
                                }
                                """))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.sourceYear").value(2023))
                .andExpect(jsonPath("$.decision").value("NEEDS_PERMISSION"));
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
    void adminCanListAndDisableUserAccount() throws Exception {
        var loginResponse = mockMvc.perform(post("/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"username\":\"student-extra\",\"password\":\"yanma408\"}"))
                .andExpect(status().isOk())
                .andReturn()
                .getResponse()
                .getContentAsString();
        var token = com.jayway.jsonpath.JsonPath.read(loginResponse, "$.token").toString();

        mockMvc.perform(get("/auth/users"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[?(@.username == 'student-extra')].enabled").value(true));

        mockMvc.perform(patch("/auth/users/{id}/enabled", EXTRA_STUDENT_USER_ID)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"enabled\":false}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.enabled").value(false))
                .andExpect(jsonPath("$.activeTokenCount").value(0));

        Boolean enabled = jdbcTemplate.queryForObject("SELECT enabled FROM app_users WHERE id = ?", Boolean.class, EXTRA_STUDENT_USER_ID);
        Integer activeTokens = jdbcTemplate.queryForObject("""
                SELECT COUNT(*) FROM auth_tokens
                WHERE token_hash = ? AND revoked_at IS NULL AND expires_at > CURRENT_TIMESTAMP
                """, Integer.class, sha256(token));
        assertEquals(false, enabled);
        assertEquals(0, activeTokens);

        mockMvc.perform(post("/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"username\":\"student-extra\",\"password\":\"yanma408\"}"))
                .andExpect(status().isUnauthorized())
                .andExpect(jsonPath("$.message").value("该账号已被停用，请联系管理员。"));
    }

    @Test
    void registrationRateLimitBlocksRepeatedRequestsFromOneAddress() throws Exception {
        var remoteAddress = "203.0.113.77";
        for (int index = 0; index < 5; index++) {
            mockMvc.perform(post("/auth/register")
                            .with(request -> {
                                request.setRemoteAddr(remoteAddress);
                                return request;
                            })
                            .contentType(MediaType.APPLICATION_JSON)
                            .content("""
                                    {
                                      "username": "registration-rate-%d",
                                      "displayName": "限流测试%d",
                                      "password": "rate-limit-408"
                                    }
                                    """.formatted(index, index)))
                    .andExpect(status().isOk());
        }

        mockMvc.perform(post("/auth/register")
                        .with(request -> {
                            request.setRemoteAddr(remoteAddress);
                            return request;
                        })
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "username": "registration-rate-blocked",
                                  "displayName": "限流测试",
                                  "password": "rate-limit-408"
                                }
                                """))
                .andExpect(status().isTooManyRequests())
                .andExpect(jsonPath("$.code").value("RATE_LIMITED"));
    }

    @Test
    @WithMockUser(username = "00000000-0000-0000-0000-000000000901")
    void nonAdminCannotListUserSecurityDetails() throws Exception {
        mockMvc.perform(get("/auth/users"))
                .andExpect(status().isForbidden());
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
