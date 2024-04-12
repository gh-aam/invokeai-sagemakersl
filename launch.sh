#!/bin/bash

eval "$(conda shell.bash hook)"
conda activate $INVOKEAI_ROOT/.venv
if [ $# -eq 0 ]; then
    python ngrok.py
elif [ $1 = "reset" ]; then
    python ngrok.py --reset
fi
