package com.hlulani.sanelle.service;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.UncheckedIOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.UUID;

/** Saves uploaded meal images to disk; the folder is served publicly at {@link #URL_PATTERN}. */
@Component
public class ImageStorage {

    public static final Path DIRECTORY = Path.of("uploads");
    public static final String URL_PREFIX = "/uploads/";
    public static final String URL_PATTERN = URL_PREFIX + "**";

    /** @return the public URL of the saved image */
    public String save(MultipartFile image) {
        String fileName = UUID.randomUUID() + "_" + image.getOriginalFilename();
        try {
            Files.createDirectories(DIRECTORY);
            Files.copy(image.getInputStream(), DIRECTORY.resolve(fileName));
        } catch (IOException e) {
            throw new UncheckedIOException("Could not save image", e);
        }
        return URL_PREFIX + fileName;
    }
}
