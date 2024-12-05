# Script to configure Git and ADB on Windows
Write-Host "Starting environment setup on Windows..." -ForegroundColor Cyan

# URLs and paths
$gitInstallerUrl = "https://github.com/git-for-windows/git/releases/download/v2.47.1.windows.1/Git-2.47.1-64-bit.exe"
$platformToolsUrl = "https://dl.google.com/android/repository/platform-tools-latest-windows.zip?hl=pt-br"
$downloadsDir = [System.Environment]::GetFolderPath("MyDocuments").Replace("\Documents", "\Downloads")
$gitInstallerPath = Join-Path -Path $downloadsDir -ChildPath "GitInstaller.exe"
$platformToolsZip = Join-Path -Path $downloadsDir -ChildPath "platform-tools-latest-windows.zip"
$platformToolsDir = Join-Path -Path $downloadsDir -ChildPath "platform-tools"

# Path of the main.sh script in the /scripts/ subfolder
$currentScriptPath = $PSScriptRoot
$mainScriptPath = Join-Path -Path $currentScriptPath -ChildPath "scripts/main.sh"

# Check if the default Downloads directory exists
if (-Not (Test-Path -Path $downloadsDir)) {
    Write-Host "Error: The default Downloads directory was not found." -ForegroundColor Red
    exit 1
}

# Install Git
Write-Host "Downloading the Git installer..."
try {
    Invoke-WebRequest -Uri $gitInstallerUrl -OutFile $gitInstallerPath -UseBasicParsing
    Write-Host "Git installer download complete!" -ForegroundColor Green
} catch {
    Write-Host "Error downloading the Git installer. Check your internet connection." -ForegroundColor Red
    exit 1
}

Write-Host "Installing Git silently..."
try {
    Start-Process -FilePath $gitInstallerPath -ArgumentList "/silent" -Wait
    Write-Host "Git installed successfully!" -ForegroundColor Green
} catch {
    Write-Host "Error installing Git. Make sure you have administrative permissions." -ForegroundColor Red
    exit 1
}

# Ensure Git is in PATH
Write-Host "Checking Git installation..."
try {
    git --version > $null 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Git is installed and accessible via PATH!" -ForegroundColor Green
    } else {
        Write-Host "Error: Git is not accessible via PATH. Please check the installation." -ForegroundColor Red
        exit 1
    }
} catch {
    Write-Host "Error verifying Git installation." -ForegroundColor Red
    exit 1
}

# Clone the GitHub repository
Write-Host "Cloning the repository..."
try {
    git clone https://github.com/azurejoga/aurora-android-optimizer.git
    Write-Host "Repository cloned successfully!" -ForegroundColor Green
} catch {
    Write-Host "Error cloning the repository. Check your internet connection or Git configuration." -ForegroundColor Red
    exit 1
}

# Navigate to the repository folder
$repoDir = Join-Path -Path $PWD -ChildPath "aurora-android-optimizer"
Write-Host "Entering the repository folder..."
if (Test-Path -Path $repoDir) {
    Set-Location -Path $repoDir
    Write-Host "Current directory: $repoDir" -ForegroundColor Green
} else {
    Write-Host "Error: Repository folder not found." -ForegroundColor Red
    exit 1
}

# Download and configure Platform Tools (ADB)
Write-Host "Downloading Platform Tools for ADB..."
try {
    Invoke-WebRequest -Uri $platformToolsUrl -OutFile $platformToolsZip -UseBasicParsing
    Write-Host "Platform Tools download complete!" -ForegroundColor Green
} catch {
    Write-Host "Error downloading Platform Tools. Check your internet connection." -ForegroundColor Red
    exit 1
}

Write-Host "Extracting Platform Tools..."
try {
    Expand-Archive -Path $platformToolsZip -DestinationPath $downloadsDir -Force
    Write-Host "Platform Tools extracted to $platformToolsDir." -ForegroundColor Green
} catch {
    Write-Host "Error extracting Platform Tools. Make sure PowerShell supports Expand-Archive." -ForegroundColor Red
    exit 1
}

# Add Platform Tools to environment variables
Write-Host "Adding Platform Tools to environment variables..."
try {
    $envPath = [System.Environment]::GetEnvironmentVariable("Path", "User")
    if (-Not ($envPath -like "*$platformToolsDir*")) {
        [System.Environment]::SetEnvironmentVariable("Path", "$envPath;$platformToolsDir", "User")
        Write-Host "Platform Tools added to PATH successfully!" -ForegroundColor Green
    } else {
        Write-Host "Platform Tools is already in PATH." -ForegroundColor Yellow
    }
} catch {
    Write-Host "Error adding Platform Tools to environment variables." -ForegroundColor Red
    exit 1
}

# Check ADB installation
Write-Host "Checking if ADB is working..."
try {
    $adbVersion = & "$platformToolsDir\adb.exe" version
    Write-Host "`n$adbVersion" -ForegroundColor Green
    Write-Host "ADB is working correctly!" -ForegroundColor Green
} catch {
    Write-Host "Error: ADB is not working. Ensure the device is connected and USB debugging is enabled." -ForegroundColor Red
    exit 1
}

# Run the main.sh script
Write-Host "Running the 'main.sh' script located in the /scripts/... subfolder"
if (Test-Path -Path $mainScriptPath) {
    try {
        Start-Process -FilePath "bash" -ArgumentList $mainScriptPath -Wait
        Write-Host "Script 'main.sh' executed successfully!" -ForegroundColor Green
    } catch {
        Write-Host "Error executing 'main.sh'. Verify if the script exists and is correct." -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "Error: Script 'main.sh' not found in /scripts directory." -ForegroundColor Red
    exit 1
}

Write-Host "Configuration completed successfully!" -ForegroundColor Cyan
