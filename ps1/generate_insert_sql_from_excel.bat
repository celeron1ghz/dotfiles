@echo off
cd %~dp0
powershell .\generate_update_sql_from_excel.ps1 %1
pause