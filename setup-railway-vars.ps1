# Railway Environment Variables Setup Script

Write-Host "🔧 Setting Railway Environment Variables" -ForegroundColor Green
Write-Host ""

# Check if logged in
$loggedIn = railway whoami 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Not logged in to Railway" -ForegroundColor Red
    Write-Host "Please run: railway login" -ForegroundColor Yellow
    exit 1
}

Write-Host "✅ Logged in to Railway" -ForegroundColor Green
Write-Host ""

# Navigate to backend
Set-Location backend

# Link project if not linked
Write-Host "Linking Railway project..." -ForegroundColor Cyan
railway link

Write-Host ""
Write-Host "Setting environment variables..." -ForegroundColor Cyan
Write-Host ""

# Critical Variables
railway variables set GEMINI_API_KEY="AIzaSyBwe7u1tv_QbPZv3Er9pt6yvOaZ1y-gDSk"
railway variables set MONGODB_USERNAME="rajeshthummar1978_db_user"
railway variables set MONGODB_PASSWORD="Qpu0kc0TqJst3zXz"
railway variables set MONGODB_DB="TeamBond2"
railway variables set REDIS_URI="redis-16929.c330.asia-south1-1.gce.cloud.redislabs.com"
railway variables set REDIS_PORT="16929"
railway variables set REDIS_PASSWORD="4Z1zv1iNjQzqabWVadFBhw6c2w7GfPmH"

# GitHub OAuth
railway variables set YOUR_CLIENT_ID="Ov23liRLmGozCPFRwScG"
railway variables set YOUR_CLIENT_SECRET="984f2680a553e888076fd28d376ca703757d0ab5"
railway variables set redirect-uri="https://teambond-production.up.railway.app/login/oauth2/code/github"

# APIs
railway variables set "open.cage.api"="40327afcd6e04c7a958c71bcd439a800"
railway variables set GEMINI_API_KEY="AIzaSyBwe7u1tv_QbPZv3Er9pt6yvOaZ1y-gDSk"

# Email
railway variables set MAIL_ID="shetadarshan61@gmail.com"
railway variables set APP_PASSWORD="rhfj rnce vqen wbbp"

# Razorpay
railway variables set RAZORPAY_WEBHOOK_SECRET="OWGi2QD133o9Ch2mXcxdcIGx"
railway variables set RAZORPAY_KEY_ID="rzp_test_Rsg1l0yAzhuowS"
railway variables set RAZORPAY_KEY_SECRET="OWGi2QD133o9Ch2mXcxdcIGx"

# RabbitMQ
railway variables set "rabbitmq.port"="5671"
railway variables set "rabbitmq.host"="b-16012807-86aa-4809-9aa5-500695b7a431.mq.eu-north-1.on.aws"
railway variables set "rabbitmq.username"="ShetaDarshan1710"
railway variables set "rabbitmq.password"="ShetaDarshan1710"
railway variables set "rabbitmq.queue"="TeamBond"
railway variables set "rabbitmq.dlq.queue"="dlqTeamBond"
railway variables set SSL_CONNECTION="true"

# JWT
railway variables set JWT_SECRET_KEY="qwertyuiopasdfghjklzxcvbnm1234567890QWERTYUIOP"

# Frontend URL (will be updated after Vercel deploy)
railway variables set "frontend.url"="https://your-frontend.vercel.app"

Write-Host ""
Write-Host "✅ Environment variables set!" -ForegroundColor Green
Write-Host ""
Write-Host "Now run: railway up" -ForegroundColor Yellow

Set-Location ..






