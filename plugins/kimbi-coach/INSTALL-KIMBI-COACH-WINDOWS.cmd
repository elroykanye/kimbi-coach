@echo off
setlocal
title Install Kimbi Coach
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\install-windows.ps1" -SourcePath "%~dp0"
set "KIMBI_EXIT=%ERRORLEVEL%"
echo.
if not "%KIMBI_EXIT%"=="0" (
  echo Kimbi Coach was not installed. Read the error above.
) else (
  echo You can close this window after reading the next steps above.
)
pause
exit /b %KIMBI_EXIT%
