# check lazy install path: appdata/roaming vs appdata/local
# install nvm: https://github.com/coreybutler/nvm-windows/releases


# 1. CHECK FOR ADMINISTRATOR PRIVILEGES
# ---------------------------------------
# This gets the current user's identity and checks if they are in the Administrator role.
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "------------------------------------------------------------------" -ForegroundColor Red
    Write-Host "ERROR: Administrator privileges are required." -ForegroundColor Red
    Write-Host "------------------------------------------------------------------" -ForegroundColor Red
    exit 
} else {
    Write-Host "Running with Administrator privileges. Proceeding..." -ForegroundColor Green
}

# install python: 
winget.exe install python

# install a C compiler (clang)
winget.exe install llvm

# INSTALL MSYS2 VIA WINGET (NON-INTERACTIVE)
# ---------------------------------------------
$msys2Path = "C:\msys64"
Write-Host "`nStep 2: Checking if MSYS2 is installed..." -ForegroundColor Yellow
if (-not (Test-Path "$msys2Path\msys2.exe")) {
    Write-Host "MSYS2 not found. Installing via winget..."
    winget install --id MSYS2.MSYS2 --source winget --accept-package-agreements --accept-source-agreements
    if (-not (Test-Path "$msys2Path\msys2.exe")) {
        Write-Host "ERROR: MSYS2 installation failed. Aborting." -ForegroundColor Red
        return
    }
    Write-Host "SUCCESS: MSYS2 installed." -ForegroundColor Green
} else {
    Write-Host "SUCCESS: MSYS2 is already installed." -ForegroundColor Green
}

# AUTOMATE PACMAN COMMANDS FROM POWERSHELL
# We will call the MSYS2 shell script to execute pacman commands non-interactively.
# The '--noconfirm' flag is crucial to prevent pacman from asking for user input.
$msys2_shell = "$msys2Path\msys2_shell.cmd"

Write-Host "`nStep 3: Automating MSYS2 setup and GCC installation..." -ForegroundColor Yellow
Write-Host "(This may take several minutes and you might see multiple terminal windows flash open and close)"

# The standard MSYS2 setup requires updating the core packages first, then the rest.
Write-Host "  - Updating package database and core packages..."
& $msys2_shell -ucrt64 -no-start -c "pacman --noconfirm -Syu"

Write-Host "  - Updating remaining packages..."
& $msys2_shell -ucrt64 -no-start -c "pacman --noconfirm -Su"

Write-Host "  - Installing GCC toolchain..."
& $msys2_shell -ucrt64 -no-start -c "pacman --noconfirm -S mingw-w64-ucrt-x86_64-gcc"

Write-Host "SUCCESS: GCC installation complete." -ForegroundColor Green

# 4. ADD GCC TO THE SYSTEM PATH
# -----------------------------
$mingwPath = "$msys2Path\ucrt64\bin"
Write-Host "`nStep 4: Adding GCC to the system PATH..." -ForegroundColor Yellow

if (-not (Test-Path $mingwPath)) {
    Write-Host "ERROR: Could not find the GCC bin directory at '$mingwPath'. Aborting PATH update." -ForegroundColor Red
    return
}

$currentPath = [System.Environment]::GetEnvironmentVariable("Path", "Machine")

if (-not ($currentPath -split ';').Contains($mingwPath)) {
    $newPath = $currentPath + ";" + $mingwPath
    [System.Environment]::SetEnvironmentVariable("Path", $newPath, "Machine")
    Write-Host "SUCCESS: MinGW path has been added to the system PATH." -ForegroundColor Green
} else {
    Write-Host "INFO: MinGW path is already in the system PATH. No changes needed." -ForegroundColor Cyan
}

# FINAL MESSAGE
# -------------
Write-Host "`n=============================================================================" -ForegroundColor Green
Write-Host "    AUTOMATED INSTALLATION COMPLETE!" -ForegroundColor Green
Write-Host "    You must open a NEW terminal window to use the 'gcc' command." -ForegroundColor Green
Write-Host "=============================================================================" -ForegroundColor Green
# install npm (+node?)
nvm install latest
nvm use latest

