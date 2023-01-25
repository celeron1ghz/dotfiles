@echo off
cd %~dp0
powershell .\generate_insert_sql_from_excel.ps1 %1
pause