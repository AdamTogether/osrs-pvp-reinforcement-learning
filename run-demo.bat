@echo off
REM Ensure commands run from the repository root
cd /d "%~dp0"

REM Convert the current path to the corresponding WSL path
for /f "delims=" %%i in ('wsl wslpath -a "%cd%"') do set "WSL_PATH=%%i"

REM Build the image and print the PyTorch version from inside WSL
wsl bash -lc "cd '%WSL_PATH%' && docker build -t osrs-pvp-rl . && docker run --rm osrs-pvp-rl python -c \"import torch; print('Torch version:', torch.__version__)\""

pause
