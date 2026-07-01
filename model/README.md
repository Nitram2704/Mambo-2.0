# Mambo Coach AI - Fine-tuning Guide

## Quick Start (Windows Local)

### 1. Verificar requisitos
- GPU NVIDIA con CUDA (tu RTX 4060 8GB funciona)
- Python 3.10-3.12 (recomendado, 3.14 puede tener issues)
- Drivers NVIDIA actualizados

### 2. Ejecutar setup
```bash
# Ejecutar como administrador
setup.bat
```

Esto crea un entorno virtual e instala todas las dependencias.

### 3. Entrenar
```bash
# Activar entorno
.venv\Scripts\activate

# Ir a la carpeta del modelo
cd model

# Abrir Jupyter
jupyter notebook trainer.ipynb
```

### 4. Ejecutar celdas en orden
Ejecutar todas las celdas de arriba a abajo.

## Archivos

| Archivo | Descripción |
|---------|-------------|
| `setup.bat` | Script de setup automatizado |
| `trainer.ipynb` | Notebook principal con pipeline completo |
| `dataset_entrenador_mambo.csv` | 100 ejemplos de entrenamiento |
| `requirements.txt` | Dependencias de Python |

## Flujo de entrenamiento

1. **Verificar GPU** - Chequeo automático de CUDA
2. **Dataset** - Carga CSV → formato ShareGPT
3. **Modelo** - Gemma 4 2B IT con 4-bit quantization
4. **LoRA** - Adaptador r=16 para fine-tuning eficiente
5. **Entrenamiento** - SFTTrainer, 80 steps, batch=8 effective
6. **Exportación** - GGUF q4_k_m para móvil (~2-3GB)
7. **Prueba** - Inferencia con el modelo fine-tuneado

## Especificaciones del modelo

| Parámetro | Valor |
|-----------|-------|
| Modelo base | `unsloth/gemma-4-2b-it` |
| LoRA rank | 16 |
| Learning rate | 2e-4 |
| Batch size effective | 8 (2×4) |
| Max steps | 80 |
| Quantization | 4-bit (QLoRA) |
| GGUF export | q4_k_m |

## VRAM Estimada

| Componente | VRAM |
|------------|------|
| Modelo 4-bit | ~2 GB |
| LoRA + optimizer | ~1.5 GB |
| Activaciones | ~1.5 GB |
| **Total** | **~5 GB** (cabe en 8GB) |

## Output esperado

- `mambo_coach_gguf/` - Directorio con modelo GGUF
- Archivo `.gguf` de ~2-3GB para inference en móvil

## Solución de problemas

### "No torch CUDA available"
→ Verificar drivers NVIDIA: `nvidia-smi`
→ Reinstalar PyTorch: `pip install torch --index-url https://download.pytorch.org/whl/cu121`

### Out of memory
→ Reducir `max_seq_length` a 1024
→ Reducir `per_device_train_batch_size` a 1

### Python 3.14 errors
→ Crear entorno con Python 3.11: `py -3.11 -m venv .venv`

### Unsloth install fails
→ WSL2 es la opción más estable en Windows
→ O usar Conda: `conda install -c conda-forge unsloth`
