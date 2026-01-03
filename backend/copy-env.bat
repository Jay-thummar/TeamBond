@echo off
echo ========================================
echo Copy .env file to Backend Directory
echo ========================================
echo.
echo Please provide the path to your .env file
echo Example: C:\Users\DELL\Downloads\.env
echo.
set /p ENV_PATH="Enter .env file path: "

if not exist "%ENV_PATH%" (
    echo.
    echo ERROR: File not found at: %ENV_PATH%
    echo.
    pause
    exit /b 1
)

echo.
echo Copying .env file...
copy "%ENV_PATH%" "%~dp0.env" >nul

if %ERRORLEVEL% EQU 0 (
    echo.
    echo SUCCESS: .env file copied to backend directory!
    echo.
    echo You can now run: deploy.bat
) else (
    echo.
    echo ERROR: Failed to copy .env file
)

echo.
pause


