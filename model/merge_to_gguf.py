"""
Mambo Coach AI - Merge LoRA into base model + Convert to GGUF

Pipeline:
1. Load base Gemma 4 E2B in float16 on CPU
2. Apply LoRA weights directly to model tensors
3. Save merged model in HuggingFace format
4. Convert to GGUF using llama.cpp
5. Quantize to q4_k_m
"""

import os
import sys
import json
import shutil
import subprocess
from pathlib import Path

import torch
from transformers import AutoModelForCausalLM, AutoTokenizer

# Configuration
BASE_MODEL = "google/gemma-4-E2B-it"
LORA_DIR = Path("mambo_coach_lora")
MERGED_DIR = Path("mambo_coach_merged")
GGUF_DIR = Path("mambo_coach_gguf")
LLAMA_CPP = Path("../llama.cpp")

def load_lora_weights(lora_dir):
    """Load LoRA weights from our custom format."""
    lora_path = lora_dir / "lora_weights.pt"
    config_path = lora_dir / "config.json"
    
    with open(config_path) as f:
        config = json.load(f)
    
    lora_state = torch.load(lora_path, map_location="cpu")
    print(f"Loaded LoRA weights: {len(lora_state)} tensors")
    return lora_state, config


def merge_lora_into_model(model, lora_state):
    """Apply LoRA weights directly to model tensors (in-place merge)."""
    merged_count = 0
    
    # Keys are like "layers.0.self_attn.q_proj.lora_A"
    # Navigate from model.model.language_model
    lm = model.model.language_model
    
    # Group keys by module (remove .lora_A/.lora_B suffix)
    module_keys = {}
    for key, weight in lora_state.items():
        if ".lora_A" in key:
            module_name = key.replace(".lora_A", "")
            module_keys.setdefault(module_name, {})["lora_A"] = weight
        elif ".lora_B" in key:
            module_name = key.replace(".lora_B", "")
            module_keys.setdefault(module_name, {})["lora_B"] = weight
    
    for module_name, weights in module_keys.items():
        if "lora_A" not in weights or "lora_B" not in weights:
            continue
        
        # Navigate to the module (e.g. "layers.0.self_attn.q_proj")
        parts = module_name.split(".")
        parent = lm
        for part in parts:
            parent = getattr(parent, part)
        
        original_weight = parent.weight.data
        lora_A = weights["lora_A"].to(torch.float32)  # (r, in_features)
        lora_B = weights["lora_B"].to(torch.float32)  # (out_features, r)
        
        # delta = B @ A * scaling = (out_features, r) @ (r, in_features) = (out_features, in_features)
        scaling = 1.0  # alpha/r = 16/16
        delta = lora_B @ lora_A * scaling
        
        # Merge: W_merged = W_original + delta
        parent.weight.data = (original_weight.to(torch.float32) + delta).to(original_weight.dtype)
        
        merged_count += 1
    
    print(f"  Merged: {merged_count} modules")
    return model


def main():
    print("=" * 60)
    print("MAMBO COACH AI - Merge LoRA + GGUF Conversion")
    print("=" * 60)
    
    # Check requirements
    if not LORA_DIR.exists():
        print(f"ERROR: LoRA directory not found: {LORA_DIR}")
        sys.exit(1)
    
    if not LLAMA_CPP.exists():
        print(f"ERROR: llama.cpp not found at {LLAMA_CPP}")
        print("Clone it first: git clone https://github.com/ggerganov/llama.cpp.git")
        sys.exit(1)
    
    # Step 1: Load LoRA weights
    print("\n[1/5] Loading LoRA weights...")
    lora_state, lora_config = load_lora_weights(LORA_DIR)
    
    # Step 2: Load base model in float16 on CPU
    print("\n[2/5] Loading base model (this may take a few minutes)...")
    print("  Using float16 on CPU (requires ~10GB RAM)")
    
    tokenizer = AutoTokenizer.from_pretrained(BASE_MODEL)
    model = AutoModelForCausalLM.from_pretrained(
        BASE_MODEL,
        dtype=torch.float16,
        device_map="cpu",
    )
    
    print(f"  Model loaded: {type(model).__name__}")
    
    # Step 3: Merge LoRA weights
    print("\n[3/5] Merging LoRA weights into base model...")
    model = merge_lora_into_model(model, lora_state)
    
    # Step 4: Save merged model
    print("\n[4/5] Saving merged model...")
    MERGED_DIR.mkdir(exist_ok=True)
    
    model.save_pretrained(MERGED_DIR)
    tokenizer.save_pretrained(MERGED_DIR)
    
    # Save config
    merge_info = {
        "base_model": BASE_MODEL,
        "lora_r": lora_config.get("lora_r", 16),
        "lora_alpha": lora_config.get("lora_alpha", 16),
        "merged": True,
        "format": "float16",
    }
    with open(MERGED_DIR / "merge_info.json", "w") as f:
        json.dump(merge_info, f, indent=2)
    
    merged_size = sum(f.stat().st_size for f in MERGED_DIR.rglob("*") if f.is_file())
    print(f"  Saved to {MERGED_DIR}/ ({merged_size / 1024**3:.2f} GB)")
    
    # Free memory
    del model
    import gc
    gc.collect()
    
    # Step 5: Convert to GGUF
    print("\n[5/5] Converting to GGUF q4_k_m...")
    
    GGUF_DIR.mkdir(exist_ok=True)
    
    convert_script = LLAMA_CPP / "convert_hf_to_gguf.py"
    if not convert_script.exists():
        print(f"  WARNING: {convert_script} not found")
        print("  Falling back to manual conversion instructions")
        print(f"\n  To convert manually:")
        print(f"    cd {LLAMA_CPP}")
        print(f"    python convert_hf_to_gguf.py ../model/mambo_coach_merged --outfile ../model/mambo_coach_gguf/mambo-coach-f16.gguf --outtype f16")
        print(f"    ./llama-quantize ../model/mambo_coach_gguf/mambo-coach-f16.gguf ../model/mambo_coach_gguf/mambo-coach-q4_k_m.gguf Q4_K_M")
        return
    
    # Convert to f16 GGUF first
    f16_gguf = GGUF_DIR / "mambo-coach-f16.gguf"
    print(f"  Converting to f16 GGUF: {f16_gguf}")
    
    cmd_convert = [
        sys.executable, str(convert_script),
        str(MERGED_DIR),
        "--outfile", str(f16_gguf),
        "--outtype", "f16",
    ]
    
    result = subprocess.run(cmd_convert, capture_output=True, text=True)
    if result.returncode != 0:
        print(f"  ERROR during conversion:\n{result.stderr}")
        sys.exit(1)
    print(f"  f16 GGUF created: {f16_gguf.stat().st_size / 1024**3:.2f} GB")
    
    # Quantize to q4_k_m
    quantize_bin = LLAMA_CPP / "llama-quantize"
    if sys.platform == "win32":
        quantize_bin = LLAMA_CPP / "build" / "bin" / "Release" / "llama-quantize.exe"
        if not quantize_bin.exists():
            quantize_bin = LLAMA_CPP / "llama-quantize.exe"
    
    q4_gguf = GGUF_DIR / "mambo-coach-q4_k_m.gguf"
    print(f"  Quantizing to q4_k_m: {q4_gguf}")
    
    if quantize_bin.exists():
        cmd_quantize = [str(quantize_bin), str(f16_gguf), str(q4_gguf), "Q4_K_M"]
        result = subprocess.run(cmd_quantize, capture_output=True, text=True)
        if result.returncode != 0:
            print(f"  ERROR during quantization:\n{result.stderr}")
            print("  You may need to build llama.cpp first:")
            print("    cd llama.cpp")
            print("    cmake -B build")
            print("    cmake --build build --config Release")
            sys.exit(1)
        print(f"  q4_k_m GGUF created: {q4_gguf.stat().st_size / 1024**2:.1f} MB")
    else:
        print(f"  quantize binary not found at {quantize_bin}")
        print("  Build llama.cpp first:")
        print("    cd llama.cpp")
        print("    cmake -B build")
        print("    cmake --build build --config Release")
        print(f"\n  Then run manually:")
        print(f"    llama-quantize {f16_gguf} {q4_gguf} Q4_K_M")
    
    # Summary
    print("\n" + "=" * 60)
    print("COMPLETED!")
    print("=" * 60)
    print(f"\nFiles created:")
    print(f"  {MERGED_DIR}/     - Merged HF model (float16)")
    if q4_gguf.exists():
        print(f"  {q4_gguf}  - GGUF q4_k_m (ready for mobile)")
        print(f"\n  Size: {q4_gguf.stat().st_size / 1024**2:.1f} MB")
    print(f"\n  Copy the GGUF file to your Flutter assets:")
    print(f"    cp {q4_gguf} vitalis_app/assets/mambo-coach.gguf")


if __name__ == "__main__":
    main()
