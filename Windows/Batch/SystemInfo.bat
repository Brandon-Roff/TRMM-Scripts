@echo off
REM System Info
systeminfo | find "Host Name" | find "OS" | find "Memory" | find "Processor" | find "Network Card" | find "IP Address" | find "Default Gateway" | find "DNS Servers"


