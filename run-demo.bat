@echo off
docker build -t osrs-pvp-rl .
docker run --rm osrs-pvp-rl bash -lc "python -c \"import torch; print('Torch version:', torch.__version__)\""
pause
