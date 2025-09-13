package com.ideaflow.noveldownload.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class CorsConfig implements WebMvcConfigurer {
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")
                // 允许本地来源，生产环境建议设置具体的域名
                //.allowedOriginPatterns("*")
                .allowedOriginPatterns(
                    "http://localhost:[*]",
                    "http://127.0.0.1:[*]", 
                    "http://192.168.11.50:[*]",
                    "http://book.wdllstudio.com:[*]",
                    "http://crawler.wdllstudio.net"
                )
                .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS")
                .allowedHeaders("*")
                .allowCredentials(true)
                .maxAge(3600);
    }
}