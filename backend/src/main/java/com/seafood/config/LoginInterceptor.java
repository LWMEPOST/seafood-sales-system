package com.seafood.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.seafood.common.Result;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import java.io.IOException;

@Component
public class LoginInterceptor implements HandlerInterceptor {

    private final ObjectMapper objectMapper = new ObjectMapper();

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // Allow OPTIONS requests for CORS preflight
        if ("OPTIONS".equalsIgnoreCase(request.getMethod())) {
            return true;
        }

        String token = request.getHeader("Authorization");
        
        // Simple token validation: check if it exists and starts with the expected prefix
        // In a real application, you would validate the token signature and expiration here
        if (token != null && token.startsWith("mock-token-")) {
            return true;
        }

        // Return 401 Unauthorized
        returnUnauthorized(response);
        return false;
    }

    private void returnUnauthorized(HttpServletResponse response) throws IOException {
        response.setContentType("application/json;charset=UTF-8");
        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        Result<String> result = Result.error("Unauthorized: Please log in first");
        response.getWriter().write(objectMapper.writeValueAsString(result));
    }
}
