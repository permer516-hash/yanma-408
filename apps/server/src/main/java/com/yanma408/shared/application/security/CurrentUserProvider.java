package com.yanma408.shared.application.security;

import java.util.UUID;

public interface CurrentUserProvider {
    UUID currentUserId();
}
