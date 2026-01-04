# Complete Deployment Script - Railway + Vercel

Write-Host "🚀 Complete Deployment - Railway + Vercel" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Green
Write-Host ""

# Check Railway login
Write-Host "Checking Railway login..." -ForegroundColor Cyan
$railwayCheck = railway whoami 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Not logged in to Railway" -ForegroundColor Red
    Write-Host "Run: railway login" -ForegroundColor Yellow
    Write-Host ""
    railway login
    Write-Host ""
}

# Check Vercel login
Write-Host "Checking Vercel login..." -ForegroundColor Cyan
$vercelCheck = vercel whoami 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Not logged in to Vercel" -ForegroundColor Red
    Write-Host "Run: vercel login" -ForegroundColor Yellow
    Write-Host ""
    vercel login
    Write-Host ""
}

Write-Host "✅ Both services logged in!" -ForegroundColor Green
Write-Host ""

# Deploy Backend
Write-Host "==========================================" -ForegroundColor Green
Write-Host "🚀 Deploying Backend to Railway..." -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Green
Write-Host ""

Set-Location backend
railway link
railway up --detach
Set-Location ..

Write-Host ""
Write-Host "✅ Backend deployment initiated!" -ForegroundColor Green
Write-Host ""

# Deploy Frontend
Write-Host "==========================================" -ForegroundColor Green
Write-Host "🎨 Deploying Frontend to Vercel..." -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Green
Write-Host ""

Set-Location "frontend\CodeAmigos--Frontend-main"
vercel --prod
Set-Location ..\..

Write-Host ""
Write-Host "==========================================" -ForegroundColor Green
Write-Host "✅ Deployment Complete!" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Check Railway and Vercel dashboards for deployment status" -ForegroundColor Yellow





