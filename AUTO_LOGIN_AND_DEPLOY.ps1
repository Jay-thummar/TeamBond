# Auto Login and Deploy Script

Write-Host "🚀 Auto Login and Deploy" -ForegroundColor Green
Write-Host ""

# Open login pages
Write-Host "Opening Railway login page..." -ForegroundColor Cyan
Start-Process "https://railway.app/login"

Write-Host "Opening Vercel login page..." -ForegroundColor Cyan
Start-Process "https://vercel.com/login"

Write-Host ""
Write-Host "Please login in the browser windows that opened" -ForegroundColor Yellow
Write-Host "After logging in, press any key to continue..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

# Check Railway login
Write-Host ""
Write-Host "Checking Railway login..." -ForegroundColor Cyan
$railwayCheck = railway whoami 2>&1
if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Railway logged in!" -ForegroundColor Green
} else {
    Write-Host "❌ Railway not logged in. Please run: railway login" -ForegroundColor Red
    railway login
}

# Check Vercel login
Write-Host ""
Write-Host "Checking Vercel login..." -ForegroundColor Cyan
$vercelCheck = vercel whoami 2>&1
if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Vercel logged in!" -ForegroundColor Green
} else {
    Write-Host "❌ Vercel not logged in. Please run: vercel login" -ForegroundColor Red
    vercel login
}

Write-Host ""
Write-Host "==========================================" -ForegroundColor Green
Write-Host "🚀 Starting Deployment..." -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Green
Write-Host ""

# Deploy Backend
Write-Host "Deploying Backend to Railway..." -ForegroundColor Cyan
Set-Location backend
railway link
railway up --detach
Set-Location ..

Write-Host ""
Write-Host "Deploying Frontend to Vercel..." -ForegroundColor Cyan
Set-Location "frontend\CodeAmigos--Frontend-main"
vercel --prod
Set-Location ..\..

Write-Host ""
Write-Host "✅ Deployment Complete!" -ForegroundColor Green






