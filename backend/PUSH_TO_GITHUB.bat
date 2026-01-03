@echo off
echo ========================================
echo CodeAmigos Backend - Push to GitHub
echo ========================================
echo.

REM Check if .env is ignored
git check-ignore .env >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo WARNING: .env file is NOT in .gitignore!
    echo Please add .env to .gitignore before pushing.
    echo.
    pause
    exit /b 1
)

echo Step 1: Checking git status...
git status
echo.

echo Step 2: Adding files...
git add .
echo.

echo Step 3: Committing...
git commit -m "Initial commit: CodeAmigos Backend"
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ERROR: Commit failed!
    echo Maybe no changes to commit?
    pause
    exit /b 1
)
echo.

echo Step 4: Adding remote repository...
echo.
echo Please enter your GitHub username:
set /p GITHUB_USERNAME="Username: "

git remote remove origin 2>nul
git remote add origin https://github.com/%GITHUB_USERNAME%/codeamigos-backend.git
echo.

echo Step 5: Pushing to GitHub...
echo.
echo Note: You will be asked for GitHub password/token
echo.
git branch -M main
git push -u origin main

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo SUCCESS! Code pushed to GitHub!
    echo ========================================
    echo.
    echo Repository URL: https://github.com/%GITHUB_USERNAME%/codeamigos-backend
    echo.
) else (
    echo.
    echo ERROR: Push failed!
    echo.
    echo Common issues:
    echo 1. Repository not created on GitHub
    echo 2. Wrong username
    echo 3. Need Personal Access Token instead of password
    echo.
)

pause

