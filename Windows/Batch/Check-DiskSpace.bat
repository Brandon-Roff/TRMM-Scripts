@echo off
wmic logicaldisk get size,freespace,caption | find "C:"


