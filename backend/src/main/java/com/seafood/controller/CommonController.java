package com.seafood.controller;

import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.IdUtil;
import com.seafood.common.Result;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import jakarta.servlet.http.HttpServletRequest;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@Tag(name = "通用接口")
@RestController
@RequestMapping("/api/common")
@CrossOrigin
public class CommonController {

    @Value("${app.upload-dir}")
    private String uploadDir;

    @Operation(summary = "文件上传")
    @PostMapping("/upload")
    public Result<String> upload(MultipartFile file, HttpServletRequest request) {
        if (file == null || file.isEmpty()) {
            return Result.error("文件为空");
        }
        try {
            String originalFilename = file.getOriginalFilename();
            String suffix = FileUtil.extName(originalFilename);
            String fileName = IdUtil.simpleUUID() + "." + suffix;

            Path uploadPath = Paths.get(uploadDir).toAbsolutePath().normalize();
            Files.createDirectories(uploadPath);
            file.transferTo(uploadPath.resolve(fileName));

            String url = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/uploads/" + fileName;
            return Result.success(url);
        } catch (IOException e) {
            e.printStackTrace();
            return Result.error("文件上传失败: " + e.getMessage());
        }
    }

    @Operation(summary = "Excel导入")
    @PostMapping("/import")
    public Result<String> importExcel(MultipartFile file, HttpServletRequest request) {
        if (file == null || file.isEmpty()) {
            return Result.error("文件为空");
        }
        try {
            String originalFilename = file.getOriginalFilename();
            String suffix = FileUtil.extName(originalFilename);
            String fileName = "import_" + IdUtil.simpleUUID() + "." + suffix;

            Path importPath = Paths.get(uploadDir).toAbsolutePath().normalize().resolve("imports");
            Files.createDirectories(importPath);
            file.transferTo(importPath.resolve(fileName));

            String url = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/uploads/imports/" + fileName;
            return Result.success(url);
        } catch (IOException e) {
            e.printStackTrace();
            return Result.error("导入失败: " + e.getMessage());
        }
    }
}
