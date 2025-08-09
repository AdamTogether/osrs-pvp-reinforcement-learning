@echo off
SETLOCAL EnableDelayedExpansion

echo Checking Windows 11 prerequisites for OSRS PvP RL...

REM Check WSL
wsl.exe -l -q >NUL 2>&1
if ERRORLEVEL 1 (
    echo WSL not detected.
    set /p wslInstall="Install WSL now? (Y/N): "
    if /I "!wslInstall!"=="Y" (
        wsl --install
    ) else (
        echo Skipping WSL installation.
    )
) else (
    echo WSL is installed.
)

REM Check Docker
docker --version >NUL 2>&1
if ERRORLEVEL 1 (
    echo Docker Desktop not found.
    set /p dockerInstall="Open Docker Desktop download page? (Y/N): "
    if /I "!dockerInstall!"=="Y" (
        start https://docs.docker.com/desktop/install/windows-install/
    )
) else (
    echo Docker Desktop is installed.
)

REM Check NVIDIA driver
nvidia-smi >NUL 2>&1
if ERRORLEVEL 1 (
    echo NVIDIA GPU driver not detected.
    set /p driverInstall="Open NVIDIA driver download page? (Y/N): "
    if /I "!driverInstall!"=="Y" (
        start https://www.nvidia.com/Download/index.aspx
    )
) else (
    echo NVIDIA GPU driver detected.
)

REM Check NVIDIA Container Toolkit
wsl -e nvidia-container-cli -V >NUL 2>&1
if ERRORLEVEL 1 (
    echo NVIDIA Container Toolkit not detected in WSL.
    set /p toolkitInstall="Install NVIDIA Container Toolkit now? (Y/N): "
    if /I "!toolkitInstall!"=="Y" (
        wsl -e bash -lc "distribution=\$(. /etc/os-release;echo \$ID\$VERSION_ID) ^&^& curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey ^| sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg ^&^& curl -s -L https://nvidia.github.io/libnvidia-container/\$distribution/libnvidia-container.list ^| sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' ^| sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list ^&^& sudo apt-get update ^&^& sudo apt-get install -y nvidia-container-toolkit ^&^& sudo nvidia-ctk runtime configure --runtime=docker ^&^& sudo service docker restart"
    ) else (
        echo Skipping toolkit installation.
    )
) else (
    echo NVIDIA Container Toolkit detected.
)

echo.
echo Setup check complete.
pause
