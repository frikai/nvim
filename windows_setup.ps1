# check lazy install path: appdata/roaming vs appdata/local
# check if nvm is installed
if (-not (Get-Command nvm -ErrorAction SilentlyContinue)) {
    Write-Host "NVM is not installed. Please manually install NVM from https://github.com/coreybutler/nvm-windows/release and try again." -ForegroundColor Red
    exit
} else {
    Write-Host "Python is already installed." -ForegroundColor Yellow
}
# check if python is installed
if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
    Write-Host "Python is not installed. Please manually install Python from https://www.python.org/downloads/ and try again." -ForegroundColor Red
    exit
} else {
    Write-Host "Python is already installed." -ForegroundColor Yellow
}
# check if running as admin
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "------------------------------------------------------------------" -ForegroundColor Red
    Write-Host "ERROR: Administrator privileges are required." -ForegroundColor Red
    Write-Host "------------------------------------------------------------------" -ForegroundColor Red
    exit 
} else {
    Write-Host "Running with Administrator privileges. Proceeding..." -ForegroundColor Green
}

# install chocolatey to install gcc
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Chocolatey..." -ForegroundColor Green
} else {
    Write-Host "Chocolatey is already installed." -ForegroundColor Yellow
}
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# install a C compiler 
choco install mingw

# refresh environment
Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
refreshenv

# install npm (+node?)
nvm install latest
nvm use latest

Write-Host "Setup complete. Might need to restart terminal" -ForegroundColor Green
