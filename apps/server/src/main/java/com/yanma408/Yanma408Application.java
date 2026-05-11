package com.yanma408;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class Yanma408Application {

    public static void main(String[] args) {
        SpringApplication.run(Yanma408Application.class, args);
    }
}
