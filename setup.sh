#!/bin/bash

mkdir -p ~/invokeai
cd ~/invokeai

conda create -p .venv python=3.11 glib
eval "$(conda shell.bash hook)"
conda activate ~/invokeai/.venv

python3 -m pip install --upgrade pip
pip install InvokeAI --use-pep517
pip install pyngrok

conda deactivate
