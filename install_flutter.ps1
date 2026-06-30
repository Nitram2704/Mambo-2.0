# Script to download and install Flutter locally
$installDir = "c:\Users\marti\Proyectos\Mambo 2.0\.flutter_sdk"
$zipPath = "$installDir\flutter.zip"
$flutterUrl = "https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.22.2-stable.zip"

if (-not (Test-Path $installDir)) {
    New-Item -ItemType Directory -Force -Path $installDir | Out-Null
}

if (-not (Test-Path "$installDir\flutter\bin\flutter.bat")) {
    Write-Host "Downloading Flutter SDK (approx. 700MB)..."
    try {
        Start-BitsTransfer -Source $flutterUrl -Destination $zipPath -Description "Downloading Flutter" -DisplayName "Flutter SDK"
    } catch {
        Write-Host "BitsTransfer failed, trying Invoke-WebRequest..."
        Invoke-WebRequest -Uri $flutterUrl -OutFile $zipPath
    }

    Write-Host "Extracting Flutter SDK..."
    Expand-Archive -Path $zipPath -DestinationPath $installDir -Force
    
    Write-Host "Cleaning up zip file..."
    Remove-Item -Path $zipPath -Force
} else {
    Write-Host "Flutter SDK is already installed in $installDir"
}

Write-Host "Verifying Flutter installation..."
& "$installDir\flutter\bin\flutter.bat" --version
