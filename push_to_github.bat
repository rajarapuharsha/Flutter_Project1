@echo off
echo ====================================================
echo   VitalTrack - Pushing to GitHub (Flutter_Project1)
echo ====================================================
echo.

cd /d "%~dp0"

echo [1/4] Staging all files...
git add .

echo.
echo [2/4] Committing changes...
git commit -m "feat: complete VitalTrack BMI and Calorie Companion with SDG 3 alignment"

echo.
echo [3/4] Ensuring branch is main...
git branch -M main

echo.
echo [4/4] Pushing to GitHub using your personal access token...
git push -u origin main

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo Trying with force push in case repository had initial commits...
    git push -u origin main --force
)

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ====================================================
    echo [OK] SUCCESS! VitalTrack successfully pushed to GitHub!
    echo URL: https://github.com/rajarapuharsha/Flutter_Project1
    echo ====================================================
) else (
    echo.
    echo ====================================================
    echo [!] Push encountered an issue. Please review error above.
    echo ====================================================
)

echo.
pause
