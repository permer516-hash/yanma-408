package com.yanma408.recruitment.interfaces.rest;

import com.yanma408.recruitment.application.RecruitmentLeadService;
import com.yanma408.recruitment.application.RecruitmentLeadView;
import jakarta.validation.Valid;
import jakarta.validation.constraints.AssertTrue;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/recruitment/leads")
public class RecruitmentController {
    private final RecruitmentLeadService recruitmentLeadService;

    public RecruitmentController(RecruitmentLeadService recruitmentLeadService) {
        this.recruitmentLeadService = recruitmentLeadService;
    }

    @PostMapping
    public RecruitmentLeadView submit(@Valid @RequestBody SubmitRecruitmentLeadRequest request) {
        return recruitmentLeadService.submit(
                request.contactName(),
                request.wechatContact(),
                request.examYear(),
                request.targetSchool(),
                request.studyStage(),
                request.weakSubjects(),
                request.weeklyHours(),
                request.currentConcern()
        );
    }

    public record SubmitRecruitmentLeadRequest(
            @NotBlank @Size(max = 40) String contactName,
            @NotBlank @Size(max = 80) String wechatContact,
            @NotNull @Min(2026) @Max(2035) Integer examYear,
            @Size(max = 120) String targetSchool,
            @NotBlank @Size(max = 32) String studyStage,
            @NotEmpty List<@NotBlank @Size(max = 32) String> weakSubjects,
            @Min(1) @Max(80) Integer weeklyHours,
            @Size(max = 1000) String currentConcern,
            @AssertTrue(message = "请同意信息收集说明") boolean consented
    ) {
    }
}
