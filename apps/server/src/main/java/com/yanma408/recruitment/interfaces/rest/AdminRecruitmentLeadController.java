package com.yanma408.recruitment.interfaces.rest;

import com.yanma408.recruitment.application.RecruitmentLeadPage;
import com.yanma408.recruitment.application.RecruitmentLeadService;
import com.yanma408.shared.application.security.CurrentUserProvider;
import com.yanma408.shared.application.security.UserRoleService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/admin/recruitment/leads")
public class AdminRecruitmentLeadController {
    private final RecruitmentLeadService recruitmentLeadService;
    private final CurrentUserProvider currentUserProvider;
    private final UserRoleService userRoleService;

    public AdminRecruitmentLeadController(
            RecruitmentLeadService recruitmentLeadService,
            CurrentUserProvider currentUserProvider,
            UserRoleService userRoleService
    ) {
        this.recruitmentLeadService = recruitmentLeadService;
        this.currentUserProvider = currentUserProvider;
        this.userRoleService = userRoleService;
    }

    @GetMapping
    public RecruitmentLeadPage list(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "30") int size
    ) {
        userRoleService.requireAny(currentUserProvider.currentUserId(), "ADMIN");
        return recruitmentLeadService.list(page, size);
    }
}
