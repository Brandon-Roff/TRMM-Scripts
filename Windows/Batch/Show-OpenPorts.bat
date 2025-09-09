@echo off
netstat -an | find "LISTEN" | find ":"

