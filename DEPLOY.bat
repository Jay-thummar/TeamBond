@echo off
echo ========================================
echo   Complete Deployment - Railway + Vercel
echo ========================================
echo.

echo Step 1: Checking Railway login...
railway whoami >nul 2>&1
if errorlevel 1 (
    echo Not logged in to Railway. Please login:
    railway login
    echo.
)

echo Step 2: Checking Vercel login...
vercel whoami >nul 2>&1
if errorlevel 1 (
    echo Not logged in to Vercel. Please login:
    vercel login
    echo.
)

echo.
echo ========================================
echo   Deploying Backend to Railway...
echo ========================================
echo.

cd backend
call railway link
call railway up
cd ..

echo.
echo ========================================
echo   Deploying Frontend to Vercel...
echo ========================================
echo.

cd frontend\CodeAmigos--Frontend-main
call vercel --prod
cd ..\..

echo.
echo ========================================
echo   Deployment Complete!
echo ========================================
echo.
pause





