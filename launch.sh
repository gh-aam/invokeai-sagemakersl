#!/bin/bash

eval "$(conda shell.bash hook)"
conda activate invokeai

mkdir -p /tmp/invokeai/models
if [ ! -L ~/invokeai/models ] 
then
    ln -s /tmp/invokeai/models ~/invokeai/
fi

if [ $# -eq 0 ]
then
    python ngrok.py  
elif [ $1 = "reset" ]
then
    python ngrok.py --reset 
fi
