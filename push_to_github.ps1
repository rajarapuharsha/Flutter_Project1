Write-Host "====================================================" -ForegroundColor Cyan
Write-Host "  VitalTrack - Pushing to GitHub (Flutter_Project1)" -ForegroundColor Cyan
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host ""

Set-Location -Path $PSScriptRoot

Write-Host "[1/4] Staging all files..." -ForegroundColor Yellow
git add .

Write-Host "[2/4] Committing changes..." -ForegroundColor Yellow
git commit -m "feat: complete VitalTrack BMI and Calorie Companion with SDG 3 alignment"

Write-Host "[3/4] Ensuring branch is main..." -ForegroundColor Yellow
git branch -M main

Write-Host "[4/4] Pushing to origin (https://github.com/rajarapuharsha/Flutter_Project1.git)..." -ForegroundColor Yellow
git push -u origin main

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "====================================================" -ForegroundColor Red
    Write-Host "[!] Push failed or requires authentication." -ForegroundColor Red
    Write-Host "GitHub does not accept account passwords for Git over HTTPS." -ForegroundColor Yellow
    Write-Host "Use a GitHub Personal Access Token (PAT) or sign in via VS Code." -ForegroundColor Yellow
    Write-Host "Token setup: https://github.com/settings/tokens (check 'repo' scope)" -ForegroundColor Yellow
    Write-Host "====================================================" -ForegroundColor Red
} else {
    Write-Host ""
    Write-Host "====================================================" -ForegroundColor Green
    Write-Host "[OK] SUCCESS! VitalTrack pushed to GitHub!" -ForegroundColor Green
    Write-Host "Repository: https://github.com/rajarapuharsha/Flutter_Project1" -ForegroundColor Green
    Write-Host "====================================================" -ForegroundColor Green
}

Read-Host -Prompt "Press Enter to exit"
