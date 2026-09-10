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
import static org.hamcrest.Matchers.startsWith;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
@ActiveProfiles("e2e")
class QuestionImportRecordIntegrationTest {
    @Autowired
    private MockMvc mockMvc;

    @Test
    void adminCanReviewTheQuestionsCreatedByAnImportBatch() throws Exception {
        var adminToken = login("root", "0516cyb123");
        var importResponse = mockMvc.perform(post("/admin/questions/import")
                        .header("Authorization", "Bearer " + adminToken)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "questions":[
                                    {
                                      "subjectCode":"DATA_STRUCTURE",
                                      "chapterCode":"DS_TREE",
                                      "type":"SINGLE_CHOICE",
                                      "difficulty":"BASIC",
                                      "stem":"导入记录集成测试题",
                                      "answer":"A",
                                      "explanation":"用于验证导入记录。",
                                      "source":"ORIGINAL",
                                      "score":2,
                                      "options":[
                                        {"label":"A","content":"正确"},
                                        {"label":"B","content":"错误"}
                                      ],
                                      "knowledgePointCodes":["DS_TREE_TRAVERSAL"],
                                      "tags":["integration-test"]
                                    }
                                  ]
                                }
                                """))
                .andExpect(status().isOk())
                .andReturn()
                .getResponse()
                .getContentAsString();
        var questionId = JsonPath.read(importResponse, "$[0].id").toString();

        var recordsResponse = mockMvc.perform(get("/admin/question-imports")
                        .header("Authorization", "Bearer " + adminToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.items[0].importMode").value("JSON"))
                .andExpect(jsonPath("$.items[0].questionCount").value(1))
                .andExpect(jsonPath("$.items[0].operatorUsername").value("root"))
                .andReturn()
                .getResponse()
                .getContentAsString();
        var batchId = JsonPath.read(recordsResponse, "$.items[0].id").toString();

        mockMvc.perform(get("/admin/question-imports/{batchId}", batchId)
                        .header("Authorization", "Bearer " + adminToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.items[*].questionId", hasItem(questionId)))
                .andExpect(jsonPath("$.items[0].stem", startsWith("导入记录集成测试题")));
    }

    private String login(String username, String password) throws Exception {
        var response = mockMvc.perform(post("/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"username\":\"%s\",\"password\":\"%s\"}".formatted(username, password)))
                .andExpect(status().isOk())
                .andReturn()
                .getResponse()
                .getContentAsString();
        return JsonPath.read(response, "$.token").toString();
    }
}
