package com.seafood.exception;

import com.seafood.common.Result;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(MaxUploadSizeExceededException.class)
    public Result<String> handleMaxUploadSizeExceededException(MaxUploadSizeExceededException e) {
        log.error("上传文件超过大小限制", e);
        return Result.error("上传文件过大，请上传不超过10MB的图片");
    }

    @ExceptionHandler(Exception.class)
    public Result<String> handleException(Exception e) {
        log.error("系统异常", e);
        return Result.error("系统异常: " + e.getMessage());
    }
}
