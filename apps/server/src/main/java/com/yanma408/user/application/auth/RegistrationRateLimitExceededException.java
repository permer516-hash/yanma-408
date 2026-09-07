package com.yanma408.user.application.auth;

public class RegistrationRateLimitExceededException extends RuntimeException {
    public RegistrationRateLimitExceededException() {
        super("注册操作过于频繁，请稍后再试。");
    }
}
