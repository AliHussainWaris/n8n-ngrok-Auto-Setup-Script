@echo off
setlocal enabledelayedexpansion

REM Starting N8N
start "" /B n8n start >nul 2>&1
echo Starting Program
timeout /t 5 /nobreak >nul

REM Starting Ngrok
echo Starting Ngrok...
start "" /B ngrok http 5678 >nul 2>&1

REM Wait a few seconds
timeout /t 5 /nobreak >nul

REM Get ngrok URL via local API using bitsadmin
bitsadmin /transfer tmpJob /download /priority normal http://127.0.0.1:4040/api/tunnels "%TEMP%\ngrok.json" >nul 2>&1

REM Getting the Public URL
for /f "usebackq delims=" %%u in (`powershell -NoProfile -Command ^
    "Get-Content -Raw '%TEMP%\ngrok.json' | ConvertFrom-Json | Select-Object -ExpandProperty tunnels | Select-Object -First 1 | Select-Object -ExpandProperty public_url"`) do (
    set "public_url=%%u"
)

timeout /t 5 /nobreak

REM Killing the task of n8n
taskkill /IM node.exe /F >nul 2>&1

REM Detect current user
set CURRENT_USER=%USERNAME%

REM Path to the .n8n folder for the current user
set N8N_ENV_PATH=C:\Users\%CURRENT_USER%\.n8n\.env
echo %N8N_ENV_PATH%

REM Delete old .env if it exists
if exist "%N8N_ENV_PATH%" del "%N8N_ENV_PATH%"

REM Create new .env with your variables
(
echo N8N_HOST = 0.0.0.0
echo N8N_PORT = 5678
echo WEBHOOK_URL = %public_url%
echo VUE_APP_URL_BASE_API = %public_url%
) > "%N8N_ENV_PATH%"

echo .env file created at %N8N_ENV_PATH%


REM Starting N8N Again
echo Starting N8N...
cd /d C:\Users\%USERNAME%\.n8n
start "" /B n8n start >nul 2>&1

echo Your Public URL is: !public_url!
endlocal
exit /b 0