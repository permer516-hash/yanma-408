package com.yanma408;

import com.jayway.jsonpath.JsonPath;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.web.servlet.MockMvc;

import javax.sql.DataSource;

import static org.hamcrest.Matchers.greaterThan;
import static org.hamcrest.Matchers.hasItem;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.header;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
@ActiveProfiles("e2e")
class E2eProfileIntegrationTest {
    @Autowired
    private DataSource dataSource;

    @Autowired
    private MockMvc mockMvc;

    @Test
    void e2eProfileUsesAnIsolatedInMemoryDatabase() throws Exception {
        try (var connection = dataSource.getConnection()) {
            assertTrue(connection.getMetaData().getURL().startsWith("jdbc:h2:mem:yanma408_e2e"));
        }
    }

    @Test
    void e2eProfileAllowsTheIsolatedFrontendOrigin() throws Exception {
        mockMvc.perform(get("/health").header("Origin", "http://localhost:3100"))
                .andExpect(status().isOk())
                .andExpect(header().string("Access-Control-Allow-Origin", "http://localhost:3100"));
    }

    @Test
    void e2eProfileExposesCriticalStudentContracts() throws Exception {
        mockMvc.perform(get("/health"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.status").value("ok"));

        var loginResponse = mockMvc.perform(post("/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"username\":\"demo\",\"password\":\"yanma408\"}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.username").value("demo"))
                .andReturn()
                .getResponse()
                .getContentAsString();
        var token = JsonPath.read(loginResponse, "$.token").toString();

        mockMvc.perform(get("/auth/me").header("Authorization", "Bearer " + token))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.username").value("demo"))
                .andExpect(jsonPath("$.roles", hasItem("STUDENT")));

        mockMvc.perform(get("/questions/search").param("size", "1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.total", greaterThan(0)))
                .andExpect(jsonPath("$.items.length()").value(1));
    }
}
