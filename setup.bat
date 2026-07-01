@echo off
REM ============================================
REM Mambo Coach AI - Setup para Windows
REM ============================================

echo.
echo [1/4] Creando entorno virtual...
python -m venv .venv
call .venv\Scripts\activate.bat

echo.
echo [2/4] Instalando PyTorch con CUDA 12.1...
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

echo.
echo [3/4] Instalando Unsloth y dependencias...
pip install unsloth
pip install --upgrade --no-deps unsloth

echo.
echo [4/4] Instalando dependencias adicionales...
pip install -r model\requirements.txt

echo.
echo ============================================
echo Setup completado!
echo.
echo Para entrenar:
echo   1. Activa el entorno: .venv\Scripts\activate.bat
echo   2. Ve a la carpeta model: cd model
echo   3. Abre Jupyter: jupyter notebook trainer.ipynb
echo ============================================
pause
