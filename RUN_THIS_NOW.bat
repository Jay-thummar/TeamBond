@echo off
echo ========================================
echo   Complete Deployment Script
echo ========================================
echo.
echo Opening login pages...
start https://railway.app/login
start https://vercel.com/login
echo.
echo Please login in the browser windows
echo Then come back here and press any key...
pause
echo.

echo Checking Railway...
railway whoami
if errorlevel 1 (
    echo Logging in to Railway...
    railway login
)

echo.
echo Checking Vercel...
vercel whoami
if errorlevel 1 (
    echo Logging in to Vercel...
    vercel login
)

echo.
echo ========================================
echo   Setting Railway Variables...
echo ========================================
cd backend
call railway link
call railway variables set GEMINI_API_KEY="AIzaSyBwe7u1tv_QbPZv3Er9pt6yvOaZ1y-gDSk"
call railway variables set MONGODB_USERNAME="rajeshthummar1978_db_user"
call railway variables set MONGODB_PASSWORD="Qpu0kc0TqJst3zXz"
call railway variables set MONGODB_DB="TeamBond2"
call railway variables set REDIS_URI="redis-16929.c330.asia-south1-1.gce.cloud.redislabs.com"
call railway variables set REDIS_PORT="16929"
call railway variables set REDIS_PASSWORD="4Z1zv1iNjQzqabWVadFBhw6c2w7GfPmH"
call railway variables set YOUR_CLIENT_ID="Ov23liRLmGozCPFRwScG"
call railway variables set YOUR_CLIENT_SECRET="984f2680a553e888076fd28d376ca703757d0ab5"
call railway variables set "redirect-uri"="https://teambond-production.up.railway.app/login/oauth2/code/github"
call railway variables set "open.cage.api"="40327afcd6e04c7a958c71bcd439a800"
call railway variables set MAIL_ID="shetadarshan61@gmail.com"
call railway variables set APP_PASSWORD="rhfj rnce vqen wbbp"
call railway variables set RAZORPAY_WEBHOOK_SECRET="OWGi2QD133o9Ch2mXcxdcIGx"
call railway variables set RAZORPAY_KEY_ID="rzp_test_Rsg1l0yAzhuowS"
call railway variables set RAZORPAY_KEY_SECRET="OWGi2QD133o9Ch2mXcxdcIGx"
call railway variables set "rabbitmq.port"="5671"
call railway variables set "rabbitmq.host"="b-16012807-86aa-4809-9aa5-500695b7a431.mq.eu-north-1.on.aws"
call railway variables set "rabbitmq.username"="ShetaDarshan1710"
call railway variables set "rabbitmq.password"="ShetaDarshan1710"
call railway variables set "rabbitmq.queue"="TeamBond"
call railway variables set "rabbitmq.dlq.queue"="dlqTeamBond"
call railway variables set SSL_CONNECTION="true"
call railway variables set JWT_SECRET_KEY="qwertyuiopasdfghjklzxcvbnm1234567890QWERTYUIOP"
call railway variables set "frontend.url"="https://your-frontend.vercel.app"
echo.
echo Deploying to Railway...
call railway up
cd ..

echo.
echo ========================================
echo   Deploying Frontend to Vercel...
echo ========================================
cd frontend\CodeAmigos--Frontend-main
call vercel --prod
cd ..\..

echo.
echo ========================================
echo   Deployment Complete!
echo ========================================
pause





