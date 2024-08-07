@echo off
SETLOCAL

REM Check if computer name is CHRONOS7
if /I "%COMPUTERNAME%"=="CHRONOS7" (
    cd ahk
)

git add .
git commit -m "sync from %COMPUTERNAME%"
git push


pause
ENDLOCAL
