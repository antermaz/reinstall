
# Define the URL for the winget package
$wingetUrl = "https://sourceforge.net/projects/windows-package-manager.mirror/files/v1.9.25200/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle/download"

# Define the output path for the downloaded file
$outputPath = "$env:USERPROFILE\Downloads\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"

# # Function to download the file
# Write-Host "Downloading winget package from SourceForge..." -ForegroundColor Cyan
# Invoke-WebRequest -UserAgent "Wget" -Uri $wingetUrl -OutFile $outputPath -UseBasicParsing

# # Check if the file was downloaded successfully
# if (Test-Path $outputPath) {
#     Write-Host "Download complete. File saved to: $outputPath" -ForegroundColor Green
# } else {
#     # Function to download the file
#     Write-Host "Downloading winget package from SourceForge..." -ForegroundColor Cyan
#     Invoke-WebRequest -UserAgent "Wget" -Uri $wingetUrl -OutFile $outputPath -UseBasicParsing
#     Write-Host "Download complete. File saved to: $outputPath" -ForegroundColor Green

# }


# # Check if the file was downloaded successfully
# if ！(Test-Path $outputPath) {
#     # Write-Host "Download complete. File saved to: $outputPath" -ForegroundColor Green
#     Write-Host "Download failed. Please check your internet connection or the URL." -ForegroundColor Red
#     exit 1
# } 

# Check if the file already exists
if (Test-Path $outputPath) {
    Write-Host "Download complete. File saved to: $outputPath" -ForegroundColor Green
} else {
    # Download the file
    Write-Host "Downloading winget package from SourceForge..." -ForegroundColor Cyan
    Invoke-WebRequest -UserAgent "Wget" -Uri $wingetUrl -OutFile $outputPath -UseBasicParsing

    # Verify if the download was successful
    if (Test-Path $outputPath) {
        Write-Host "Download complete. File saved to: $outputPath" -ForegroundColor Green
    } else {
        Write-Host "Download failed. Please check your internet connection or the URL." -ForegroundColor Red
        exit 1
    }
}


# else {
#     Write-Host "Download failed. Please check your internet connection or the URL." -ForegroundColor Red
#     exit 1
# }

# ============================================================================ #
# Install prerequisites
# ============================================================================ #

Write-Section "Prerequisites"

try {
    # Define the architecture (e.g., x64, x86, arm)
    $arch = "x64"  # Change this to your target architecture
    # Download VCLibs
    $VCLibs_Url = "https://aka.ms/Microsoft.VCLibs.${arch}.14.00.Desktop.appx"
    $VCLibs_Path = [System.IO.Path]::GetTempFileName()
    # $VCLibs_Path = New-TemporaryFile2
    Write-Output "Downloading VCLibs..."
    Write-Debug "Downloading VCLibs from $VCLibs_Url to $VCLibs_Path`n`n"
    Invoke-WebRequest -Uri $VCLibs_Url -OutFile $VCLibs_Path

    # # Download UI.Xaml
    # $UIXaml_Url = "https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.8.6/Microsoft.UI.Xaml.2.8.${arch}.appx"
    # $UIXaml_Path = New-TemporaryFile2
    # Write-Output "Downloading UI.Xaml..."
    # Write-Debug "Downloading UI.Xaml from $UIXaml_Url to $UIXaml_Path"
    # Invoke-WebRequest -Uri $UIXaml_Url -OutFile $UIXaml_Path
} catch {
    $errorHandled = Handle-Error $_
    if ($null -ne $errorHandled) {
        throw $errorHandled
    }
    $errorHandled = $null
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
