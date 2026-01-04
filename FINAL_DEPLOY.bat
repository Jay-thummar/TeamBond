@echo off
chcp 65001 >nul
echo.
echo ╔══════════════════════════════════════════════════════╗
echo ║     Complete Deployment - Railway + Vercel            ║
echo ╚══════════════════════════════════════════════════════╝
echo.

REM Open login pages
echo [1/5] Opening login pages...
start https://railway.app/login
timeout /t 1 >nul
start https://vercel.com/login
echo    ✓ Login pages opened
echo.
echo    Please login in the browser windows
echo    Press any key after logging in...
pause >nul
echo.

REM Check Railway login
echo [2/5] Checking Railway login...
railway whoami >nul 2>&1
if errorlevel 1 (
    echo    ⚠ Not logged in. Opening Railway login...
    railway login
    echo    Please complete login, then press any key...
    pause >nul
) else (
    echo    ✓ Railway logged in
)

REM Check Vercel login
echo [3/5] Checking Vercel login...
vercel whoami >nul 2>&1
if errorlevel 1 (
    echo    ⚠ Not logged in. Opening Vercel login...
    vercel login
    echo    Please complete login, then press any key...
    pause >nul
) else (
    echo    ✓ Vercel logged in
)

echo.
echo [4/5] Setting Railway environment variables...
cd backend
railway link >nul 2>&1
railway variables set GEMINI_API_KEY="AIzaSyBwe7u1tv_QbPZv3Er9pt6yvOaZ1y-gDSk"
railway variables set MONGODB_USERNAME="rajeshthummar1978_db_user"
railway variables set MONGODB_PASSWORD="Qpu0kc0TqJst3zXz"
railway variables set MONGODB_DB="TeamBond2"
railway variables set REDIS_URI="redis-16929.c330.asia-south1-1.gce.cloud.redislabs.com"
railway variables set REDIS_PORT="16929"
railway variables set REDIS_PASSWORD="4Z1zv1iNjQzqabWVadFBhw6c2w7GfPmH"
railway variables set YOUR_CLIENT_ID="Ov23liRLmGozCPFRwScG"
railway variables set YOUR_CLIENT_SECRET="984f2680a553e888076fd28d376ca703757d0ab5"
railway variables set "redirect-uri"="https://teambond-production.up.railway.app/login/oauth2/code/github"
railway variables set "open.cage.api"="40327afcd6e04c7a958c71bcd439a800"
railway variables set MAIL_ID="shetadarshan61@gmail.com"
railway variables set APP_PASSWORD="rhfj rnce vqen wbbp"
railway variables set RAZORPAY_WEBHOOK_SECRET="OWGi2QD133o9Ch2mXcxdcIGx"
railway variables set RAZORPAY_KEY_ID="rzp_test_Rsg1l0yAzhuowS"
railway variables set RAZORPAY_KEY_SECRET="OWGi2QD133o9Ch2mXcxdcIGx"
railway variables set "rabbitmq.port"="5671"
railway variables set "rabbitmq.host"="b-16012807-86aa-4809-9aa5-500695b7a431.mq.eu-north-1.on.aws"
railway variables set "rabbitmq.username"="ShetaDarshan1710"
railway variables set "rabbitmq.password"="ShetaDarshan1710"
railway variables set "rabbitmq.queue"="TeamBond"
railway variables set "rabbitmq.dlq.queue"="dlqTeamBond"
railway variables set SSL_CONNECTION="true"
railway variables set JWT_SECRET_KEY="qwertyuiopasdfghjklzxcvbnm1234567890QWERTYUIOP"
railway variables set "frontend.url"="https://your-frontend.vercel.app"
echo    ✓ Variables set
echo.
echo [5/5] Deploying...
echo    → Deploying Backend to Railway...
railway up
cd ..

echo.
echo    → Deploying Frontend to Vercel...
cd frontend\CodeAmigos--Frontend-main
vercel --prod
cd ..\..

echo.
echo ╔══════════════════════════════════════════════════════╗
echo ║           ✅ Deployment Complete!                   ║
echo ╚══════════════════════════════════════════════════════╝
echo.
pause





