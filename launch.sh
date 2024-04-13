#!/bin/bash

eval "$(conda shell.bash hook)"
conda activate ~/invokeai/.venv

if [ $# -eq 0 ]; then
    python ngrok.py
elif [ $1 = "reset" ]; then
    python ngrok.py --reset
fi
