#!/bin/bash

export INVOKEAI_ROOT=~/invokeai
mkdir $INVOKEAI_ROOT

cd $INVOKEAI_ROOT
conda create -p .venv python=3.11 glib

eval "$(conda shell.bash hook)"
conda activate $INVOKEAI_ROOT/.venv
python3 -m pip install --upgrade pip
pip install InvokeAI --use-pep517
pip install pyngrok
conda deactivate
