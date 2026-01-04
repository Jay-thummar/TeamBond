# Railway Backend Deployment Script

Write-Host "🚀 Railway Backend Deployment" -ForegroundColor Green
Write-Host ""

# Check if logged in
$loggedIn = railway whoami 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Not logged in to Railway" -ForegroundColor Red
    Write-Host "Please run: railway login" -ForegroundColor Yellow
    Write-Host "Then run this script again" -ForegroundColor Yellow
    exit 1
}

Write-Host "✅ Logged in to Railway" -ForegroundColor Green
Write-Host ""

# Navigate to backend directory
Set-Location backend

Write-Host "📦 Setting up Railway project..." -ForegroundColor Cyan

# Link to existing project or create new
Write-Host "Linking to Railway project..." -ForegroundColor Cyan
railway link

# Set root directory
Write-Host "Setting root directory..." -ForegroundColor Cyan
railway variables set RAILWAY_ROOT_DIRECTORY=backend

# Deploy
Write-Host ""
Write-Host "🚀 Deploying to Railway..." -ForegroundColor Green
railway up

Write-Host ""
Write-Host "✅ Deployment initiated!" -ForegroundColor Green
Write-Host "Check Railway dashboard for deployment status" -ForegroundColor Yellow





