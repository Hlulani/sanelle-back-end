package com.hlulani.sanelle.config;

import com.hlulani.sanelle.service.ImageStorage;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler(ImageStorage.URL_PATTERN)
                .addResourceLocations("file:" + ImageStorage.DIRECTORY.toAbsolutePath() + "/");
    }
}
