@echo off
echo ========================================
echo   ACTUAL DEPLOYMENT - Railway + Vercel
echo ========================================
echo.

echo Step 1: Railway CLI Login...
railway login
if errorlevel 1 (
    echo Railway login failed!
    pause
    exit /b 1
)

echo.
echo Step 2: Vercel CLI Login...
vercel login
if errorlevel 1 (
    echo Vercel login failed!
    pause
    exit /b 1
)

echo.
echo ========================================
echo   Deploying Railway Backend...
echo ========================================
cd backend

echo Linking Railway project...
railway link
if errorlevel 1 (
    echo Failed to link Railway project!
    pause
    exit /b 1
)

echo.
echo Setting environment variables...
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

echo.
echo Deploying to Railway...
railway up
if errorlevel 1 (
    echo Railway deployment failed!
    pause
    exit /b 1
)

echo.
echo Getting Railway URL...
railway domain > railway_url.txt
type railway_url.txt

cd ..

echo.
echo ========================================
echo   Deploying Vercel Frontend...
echo ========================================
cd frontend\CodeAmigos--Frontend-main

echo.
echo Deploying to Vercel...
vercel --prod
if errorlevel 1 (
    echo Vercel deployment failed!
    pause
    exit /b 1
)

cd ..\..

echo.
echo ========================================
echo   DEPLOYMENT COMPLETE!
echo ========================================
echo.
echo Railway URL saved in: backend\railway_url.txt
echo.
pause





