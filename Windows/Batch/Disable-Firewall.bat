@echo off
echo Disabling Windows Firewall...
echo.
netsh advfirewall set allprofiles state off
echo Windows Firewall has been disabled.