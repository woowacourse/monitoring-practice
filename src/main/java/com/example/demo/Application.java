package com.example.demo;

import de.codecentric.boot.admin.server.config.EnableAdminServer;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.util.StopWatch;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

@RestController
@EnableAdminServer
@SpringBootApplication
public class Application {
    private static RestTemplate restTemplate = new RestTemplate();

    @GetMapping("/request")
    public String multiRequest(int count) throws InterruptedException {
        ExecutorService executorService = Executors.newFixedThreadPool(100);

        StopWatch stopWatch = new StopWatch();
        stopWatch.start();
        for (int i = 0; i < count; i++) {
            executorService.execute(() -> restTemplate.getForObject("http://localhost:8080", String.class));
        }
        stopWatch.stop();

        executorService.shutdown();
        executorService.awaitTermination(100, TimeUnit.SECONDS);

        return "Total Elaspsed: " + stopWatch.getTotalTimeSeconds();
    }

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}
