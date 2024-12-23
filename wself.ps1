
# Define the URL for the winget package
$wingetUrl = "https://sourceforge.net/projects/windows-package-manager.mirror/files/v1.9.25200/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle/download"

# Define the output path for the downloaded file
$outputPath = "$env:USERPROFILE\Downloads\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"

# Function to download the file
Write-Host "Downloading winget package from SourceForge..." -ForegroundColor Cyan
Invoke-WebRequest -UserAgent "Wget" -Uri $wingetUrl -OutFile $outputPath -UseBasicParsing

# Check if the file was downloaded successfully
if (Test-Path $outputPath) {
    Write-Host "Download complete. File saved to: $outputPath" -ForegroundColor Green
} else {
    Write-Host "Download failed. Please check your internet connection or the URL." -ForegroundColor Red
    exit 1
}

# Install the winget package
Write-Host "Installing winget package..." -ForegroundColor Cyan
try {
    Add-AppxPackage -Path $outputPath
    Write-Host "Winget installation completed successfully!" -ForegroundColor Green
} catch {
    Write-Host "Installation failed. Ensure that your system allows sideloading of apps." -ForegroundColor Red
    Write-Host "Run 'Set-ExecutionPolicy Bypass -Scope Process' and try again if needed." -ForegroundColor Yellow
}

# Invoke-WebRequest -UserAgent "Wget" -Uri 'https://sourceforge.net/projects/windows-package-manager.mirror/files/v1.9.25200/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle/download' -OutFile 
