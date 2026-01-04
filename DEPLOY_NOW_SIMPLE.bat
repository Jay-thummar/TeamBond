@echo off
start powershell -NoExit -Command "cd '%~dp0'; railway login; vercel login; Write-Host 'Login complete! Now run: .\RUN_DEPLOY.bat' -ForegroundColor Green"





