package com.yanma408;

import com.jayway.jsonpath.JsonPath;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.web.servlet.MockMvc;

import static org.hamcrest.Matchers.hasItem;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
@ActiveProfiles("e2e")
class ComprehensiveQuestionFlowIntegrationTest {
    @Autowired
    private MockMvc mockMvc;

    @Test
    void adminCanCreateComprehensiveQuestionStudentCanSubmitAndAdminCanGrade() throws Exception {
        var adminToken = login("root", "0516cyb123");
        var createResponse = mockMvc.perform(post("/admin/comprehensive-questions")
                        .header("Authorization", "Bearer " + adminToken)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "subjectCode":"DATA_STRUCTURE",
                                  "chapterCode":"DS_TREE",
                                  "difficulty":"MEDIUM",
                                  "stem":"集成测试综合题：请完成二叉树分析。",
                                  "source":"ORIGINAL",
                                  "score":10,
                                  "knowledgePointCodes":["DS_TREE_TRAVERSAL"],
                                  "parts":[
                                    {
                                      "prompt":"说明中序遍历顺序。",
                                      "responseMode":"RICH_TEXT",
                                      "referenceAnswer":"左、根、右。",
                                      "explanation":"先遍历左子树，再访问根，最后遍历右子树。",
                                      "score":4,
                                      "rubrics":[{"criterion":"顺序正确","score":4}]
                                    },
                                    {
                                      "prompt":"写出 C/C++ 风格伪代码。",
                                      "responseMode":"PSEUDOCODE",
                                      "referenceAnswer":"inorder(left); visit(root); inorder(right);",
                                      "explanation":"体现递归边界与访问顺序。",
                                      "score":6,
                                      "rubrics":[{"criterion":"伪代码逻辑正确","score":6}]
                                    }
                                  ]
                                }
                                """))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.type").value("COMPREHENSIVE"))
                .andExpect(jsonPath("$.comprehensiveParts.length()").value(2))
                .andReturn().getResponse().getContentAsString();

        var questionId = JsonPath.read(createResponse, "$.id").toString();
        var firstPartId = JsonPath.read(createResponse, "$.comprehensiveParts[0].id").toString();
        var secondPartId = JsonPath.read(createResponse, "$.comprehensiveParts[1].id").toString();

        var studentToken = login("demo", "yanma408");
        var submissionResponse = mockMvc.perform(post("/comprehensive-attempts/submit")
                        .header("Authorization", "Bearer " + studentToken)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "questionId":"%s",
                                  "mode":"DAILY_PRACTICE",
                                  "elapsedSeconds":180,
                                  "responses":[
                                    {"partId":"%s","content":"先左子树，再根结点，最后右子树。","attachmentUrls":[]},
                                    {"partId":"%s","content":"void inorder(Node* node) { if (!node) return; inorder(node->left); visit(node); inorder(node->right); }","attachmentUrls":[]}
                                  ]
                                }
                                """.formatted(questionId, firstPartId, secondPartId)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.status").value("PENDING_MANUAL"))
                .andExpect(jsonPath("$.responses.length()").value(2))
                .andReturn().getResponse().getContentAsString();
        var attemptId = JsonPath.read(submissionResponse, "$.id").toString();

        mockMvc.perform(get("/teacher/comprehensive-attempts/pending")
                        .header("Authorization", "Bearer " + adminToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[*].attempt.id", hasItem(attemptId)));

        mockMvc.perform(post("/teacher/comprehensive-attempts/{attemptId}/grade", attemptId)
                        .header("Authorization", "Bearer " + adminToken)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "note":"人工评分完成",
                                  "grades":[
                                    {"partId":"%s","score":4,"feedback":"遍历顺序正确。"},
                                    {"partId":"%s","score":5,"feedback":"伪代码正确，边界说明可更完整。"}
                                  ]
                                }
                                """.formatted(firstPartId, secondPartId)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.status").value("FINALIZED"))
                .andExpect(jsonPath("$.responses[0].latestScore").value(4))
                .andExpect(jsonPath("$.responses[1].latestScore").value(5));
    }

    private String login(String username, String password) throws Exception {
        var response = mockMvc.perform(post("/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"username\":\"%s\",\"password\":\"%s\"}".formatted(username, password)))
                .andExpect(status().isOk())
                .andReturn().getResponse().getContentAsString();
        return JsonPath.read(response, "$.token").toString();
    }
}
