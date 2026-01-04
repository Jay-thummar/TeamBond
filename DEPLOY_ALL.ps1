# Complete Deployment Script
$ErrorActionPreference = "Continue"
$logFile = "DEPLOYMENT_LOG.txt"

function Log-Message {
    param($msg, $color = "White")
    $time = Get-Date -Format "HH:mm:ss"
    $logMsg = "[$time] $msg"
    Write-Host $logMsg -ForegroundColor $color
    Add-Content -Path $logFile -Value $logMsg
}

Log-Message "=== Deployment Started ===" "Green"

# Check Railway
Log-Message "Checking Railway..." "Cyan"
$r = railway whoami 2>&1
if ($LASTEXITCODE -ne 0) {
    Log-Message "Railway login required" "Yellow"
    Start-Process "https://railway.app/login"
    Read-Host "Press Enter after Railway login"
}

# Check Vercel  
Log-Message "Checking Vercel..." "Cyan"
$v = vercel whoami 2>&1
if ($LASTEXITCODE -ne 0) {
    Log-Message "Vercel login required" "Yellow"
    Start-Process "https://vercel.com/login"
    Read-Host "Press Enter after Vercel login"
}

# Railway Deploy
Log-Message "Deploying Railway backend..." "Cyan"
Set-Location backend
railway link 2>&1 | Out-Null
railway variables set GEMINI_API_KEY="AIzaSyBwe7u1tv_QbPZv3Er9pt6yvOaZ1y-gDSk" 2>&1 | Out-Null
railway variables set MONGODB_USERNAME="rajeshthummar1978_db_user" 2>&1 | Out-Null
railway variables set MONGODB_PASSWORD="Qpu0kc0TqJst3zXz" 2>&1 | Out-Null
railway variables set MONGODB_DB="TeamBond2" 2>&1 | Out-Null
railway variables set REDIS_URI="redis-16929.c330.asia-south1-1.gce.cloud.redislabs.com" 2>&1 | Out-Null
railway variables set REDIS_PORT="16929" 2>&1 | Out-Null
railway variables set REDIS_PASSWORD="4Z1zv1iNjQzqabWVadFBhw6c2w7GfPmH" 2>&1 | Out-Null
railway variables set YOUR_CLIENT_ID="Ov23liRLmGozCPFRwScG" 2>&1 | Out-Null
railway variables set YOUR_CLIENT_SECRET="984f2680a553e888076fd28d376ca703757d0ab5" 2>&1 | Out-Null
railway variables set "redirect-uri"="https://teambond-production.up.railway.app/login/oauth2/code/github" 2>&1 | Out-Null
railway variables set "open.cage.api"="40327afcd6e04c7a958c71bcd439a800" 2>&1 | Out-Null
railway variables set MAIL_ID="shetadarshan61@gmail.com" 2>&1 | Out-Null
railway variables set APP_PASSWORD="rhfj rnce vqen wbbp" 2>&1 | Out-Null
railway variables set RAZORPAY_WEBHOOK_SECRET="OWGi2QD133o9Ch2mXcxdcIGx" 2>&1 | Out-Null
railway variables set RAZORPAY_KEY_ID="rzp_test_Rsg1l0yAzhuowS" 2>&1 | Out-Null
railway variables set RAZORPAY_KEY_SECRET="OWGi2QD133o9Ch2mXcxdcIGx" 2>&1 | Out-Null
railway variables set "rabbitmq.port"="5671" 2>&1 | Out-Null
railway variables set "rabbitmq.host"="b-16012807-86aa-4809-9aa5-500695b7a431.mq.eu-north-1.on.aws" 2>&1 | Out-Null
railway variables set "rabbitmq.username"="ShetaDarshan1710" 2>&1 | Out-Null
railway variables set "rabbitmq.password"="ShetaDarshan1710" 2>&1 | Out-Null
railway variables set "rabbitmq.queue"="TeamBond" 2>&1 | Out-Null
railway variables set "rabbitmq.dlq.queue"="dlqTeamBond" 2>&1 | Out-Null
railway variables set SSL_CONNECTION="true" 2>&1 | Out-Null
railway variables set JWT_SECRET_KEY="qwertyuiopasdfghjklzxcvbnm1234567890QWERTYUIOP" 2>&1 | Out-Null
railway variables set "frontend.url"="https://your-frontend.vercel.app" 2>&1 | Out-Null
Log-Message "Variables set" "Green"
railway up --detach 2>&1 | Tee-Object -FilePath "railway_deploy.txt"
$railwayUrl = railway domain 2>&1 | Out-String
Log-Message "Railway URL: $railwayUrl" "Green"
Set-Location ..

# Vercel Deploy
Log-Message "Deploying Vercel frontend..." "Cyan"
Set-Location "frontend\CodeAmigos--Frontend-main"
$vercelOut = vercel --prod 2>&1 | Out-String
Log-Message "Vercel output saved" "Green"
$vercelOut | Out-File "vercel_deploy.txt"
if ($vercelOut -match "https://[^\s]+") {
    $frontendUrl = $matches[0]
    Log-Message "Frontend URL: $frontendUrl" "Green"
}
Set-Location ..\..

# Summary
Log-Message "=== Deployment Complete ===" "Green"
Log-Message "Railway: $railwayUrl" "Cyan"
Log-Message "Vercel: $frontendUrl" "Cyan"
Log-Message "Check DEPLOYMENT_LOG.txt for details" "Yellow"






