#!/bin/bash

conda create -y -n invokeai python=3.11 glib

eval "$(conda shell.bash hook)"
conda activate invokeai

mkdir -p /tmp/invokeai/models
mkdir -p ~/invokeai
if ! test -e ~/invokeai/models
then
    ln -s /tmp/invokeai/models ~/invokeai/
fi

pip install "InvokeAI[xformers]" --use-pep517 --extra-index-url https://download.pytorch.org/whl/cu121
pip install pyngrok
python patch-16bit-model-download.py

conda deactivate
