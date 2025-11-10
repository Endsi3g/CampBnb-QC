@echo off
REM Script batch simple pour pousser rapidement les changements
echo Mise a jour automatique vers GitHub...
powershell.exe -ExecutionPolicy Bypass -File "%~dp0auto-push.ps1"
pause

