@echo off
echo ========================================
echo CodeAmigos Backend - Quick Deploy
echo ========================================
echo.

REM Check if .env exists
if not exist .env (
    echo.
    echo WARNING: .env file not found!
    echo.
    echo Please create .env file with your configuration.
    echo You can use the following template:
    echo.
    echo MONGODB_USERNAME=your_username
    echo MONGODB_PASSWORD=your_password
    echo MONGODB_DB=codeamigos
    echo REDIS_URI=redis
    echo REDIS_PORT=6379
    echo REDIS_PASSWORD=defaultpassword
    echo rabbitmq.host=rabbitmq
    echo rabbitmq.port=5672
    echo rabbitmq.username=admin
    echo rabbitmq.password=admin123
    echo ... and other required variables
    echo.
    pause
    exit /b 1
)

echo Starting deployment...
echo.

echo [1/4] Building Maven project...
call mvn clean package -DskipTests
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ERROR: Build failed! Please check the errors above.
    pause
    exit /b 1
)
echo Build successful!
echo.

echo [2/4] Starting infrastructure services (MongoDB, Redis, RabbitMQ)...
docker-compose up -d mongodb redis rabbitmq
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ERROR: Failed to start services!
    pause
    exit /b 1
)
echo Services started!
echo.

echo [3/4] Waiting for services to initialize...
timeout /t 15 /nobreak >nul
echo.

echo [4/4] Building and starting backend...
docker-compose up -d --build backend
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ERROR: Failed to start backend!
    pause
    exit /b 1
)
echo.

echo ========================================
echo Deployment Complete!
echo ========================================
echo.
echo Services are running:
echo   Backend API:     http://localhost:8080
echo   MongoDB:        localhost:27017
echo   Redis:          localhost:6379
echo   RabbitMQ:       http://localhost:15672 (admin/admin123)
echo.
echo Useful commands:
echo   View logs:      docker-compose logs -f backend
echo   Stop all:       docker-compose down
echo   Restart:        docker-compose restart
echo.
pause


