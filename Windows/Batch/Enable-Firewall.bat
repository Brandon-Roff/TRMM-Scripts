@echo off
echo Enabling Windows Firewall...
echo.
netsh advfirewall set allprofiles state on
echo Windows Firewall has been enabled.