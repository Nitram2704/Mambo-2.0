import os
os.environ["TORCHDYNAMO_DISABLE"] = "1"
os.environ["TORCHINDUCTOR_DISABLE"] = "1"
os.environ["UNSLOTH_DISABLE_AUTO_UPDATES"] = "1"

from unsloth import FastModel
print("Unsloth imported OK!")
