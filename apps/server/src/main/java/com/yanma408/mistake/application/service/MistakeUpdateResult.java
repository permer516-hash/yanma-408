package com.yanma408.mistake.application.service;

public record MistakeUpdateResult(boolean enteredMistakeBook, int wrongCount) {

    public static MistakeUpdateResult notEntered() {
        return new MistakeUpdateResult(false, 0);
    }
}
