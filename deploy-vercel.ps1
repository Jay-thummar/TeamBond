# Vercel Frontend Deployment Script

Write-Host "🎨 Vercel Frontend Deployment" -ForegroundColor Green
Write-Host ""

# Check if logged in
$loggedIn = vercel whoami 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Not logged in to Vercel" -ForegroundColor Red
    Write-Host "Please run: vercel login" -ForegroundColor Yellow
    Write-Host "Then run this script again" -ForegroundColor Yellow
    exit 1
}

Write-Host "✅ Logged in to Vercel" -ForegroundColor Green
Write-Host ""

# Navigate to frontend directory
Set-Location "frontend\CodeAmigos--Frontend-main"

Write-Host "📦 Deploying to Vercel..." -ForegroundColor Cyan
Write-Host ""

# Deploy with production flag
vercel --prod

Write-Host ""
Write-Host "✅ Deployment complete!" -ForegroundColor Green






