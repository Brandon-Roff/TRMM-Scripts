@echo off
echo Restarting Print Spooler Service...
echo .
echo Stopping Print Spooler Service...
net stop spooler > nul
echo .
echo
net start spooler
if %errorlevel% equ 0 (
    echo Print Spooler Service restarted successfully.
    exit 0
) else (
    echo Failed to restart Print Spooler Service. Please check the service status manually.
    exit 1
)
