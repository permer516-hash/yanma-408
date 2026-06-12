package com.yanma408.teacher.application;

import java.util.UUID;

public record TeacherUserView(
        UUID id,
        String username,
        String displayName
) {
}
