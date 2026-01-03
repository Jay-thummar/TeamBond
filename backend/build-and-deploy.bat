@echo off
echo ========================================
echo CodeAmigos Backend Deployment Script
echo ========================================
echo.

REM Check if .env file exists
if not exist .env (
    echo ERROR: .env file not found!
    echo Please copy .env.example to .env and fill in your values.
    pause
    exit /b 1
)

echo Step 1: Building Maven project...
call mvn clean package -DskipTests
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Maven build failed!
    pause
    exit /b 1
)
echo Build successful!
echo.

echo Step 2: Starting Docker services...
docker-compose up -d mongodb redis rabbitmq
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to start Docker services!
    pause
    exit /b 1
)
echo Docker services started!
echo.

echo Step 3: Waiting for services to be ready...
timeout /t 10 /nobreak
echo.

echo Step 4: Building and starting backend...
docker-compose up -d --build backend
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to start backend!
    pause
    exit /b 1
)
echo.

echo ========================================
echo Deployment Complete!
echo ========================================
echo.
echo Services running:
echo - Backend: http://localhost:8080
echo - MongoDB: localhost:27017
echo - Redis: localhost:6379
echo - RabbitMQ Management: http://localhost:15672
echo.
echo To view logs: docker-compose logs -f backend
echo To stop services: docker-compose down
echo.
pause


