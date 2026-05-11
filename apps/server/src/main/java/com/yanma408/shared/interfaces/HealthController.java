package com.yanma408.shared.interfaces;

import com.yanma408.shared.interfaces.dto.HealthResponse;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.Instant;

@RestController
public class HealthController {

    @GetMapping("/health")
    public HealthResponse health() {
        return new HealthResponse("ok", "yanma408-server", Instant.now());
    }
}
