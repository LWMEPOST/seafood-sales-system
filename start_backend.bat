@echo off
echo Starting Backend Service...
cd backend
call mvn spring-boot:run
if %errorlevel% neq 0 (
    echo.
    echo Error: Failed to start backend. Please ensure Maven is installed and in your PATH.
    pause
)
