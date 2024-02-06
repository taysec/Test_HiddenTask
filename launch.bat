echo off
cd %cd%
GhostTask.exe localhost add GhostTask1 "cmd.exe" "/c calc.exe" %computername% daily logon