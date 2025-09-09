@echo off
(for %%H in (8.8.8.8 1.1.1.1 google.com) do (
    echo Pinging %%H...
    ping -n 2 %%H
    echo.
))
