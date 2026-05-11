package com.yanma408.shared.interfaces.dto;

import java.time.Instant;

public record ErrorResponse(String code, String message, Instant occurredAt) {
}
