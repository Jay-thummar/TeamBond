@echo off
title Deployment - Double Click to Start
color 0A
cls
echo.
echo ========================================
echo   DEPLOYMENT STARTED
echo ========================================
echo.
echo This window will guide you through:
echo   1. Railway Login
echo   2. Vercel Login  
echo   3. Backend Deployment
echo   4. Frontend Deployment
echo.
echo Browser windows will open for login.
echo Please complete login when prompted.
echo.
pause
echo.

echo [1/4] Railway Login...
railway login
if errorlevel 1 goto error

echo.
echo [2/4] Vercel Login...
vercel login
if errorlevel 1 goto error

echo.
echo [3/4] Deploying Railway Backend...
cd backend
railway link
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
railway up
railway domain > ..\railway_url.txt
cd ..

echo.
echo [4/4] Deploying Vercel Frontend...
cd frontend\CodeAmigos--Frontend-main
vercel --prod > ..\..\vercel_url.txt 2>&1
cd ..\..

echo.
echo ========================================
echo   DEPLOYMENT COMPLETE!
echo ========================================
echo.
if exist railway_url.txt (
    echo Railway Backend URL:
    type railway_url.txt
    echo.
)
if exist vercel_url.txt (
    echo Vercel Frontend URL:
    findstr /i "https://" vercel_url.txt
    echo.
)
goto end

:error
echo.
echo ERROR: Deployment failed!
echo Please check the error messages above.
pause
exit /b 1

:end
echo.
echo URLs saved in railway_url.txt and vercel_url.txt
echo.
pause






