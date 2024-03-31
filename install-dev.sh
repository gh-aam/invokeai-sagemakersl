#!/bin/bash

dir=$(pwd)

conda create -y -n invokeai python=3.11

eval "$(conda shell.bash hook)"
conda activate invokeai

mkdir -p /tmp/invokeai/models
mkdir -p ~/invokeai
if ! test -e ~/invokeai/models
then
    ln -s /tmp/invokeai/models ~/invokeai/
fi

cd ~
git clone --depth 1 --branch v4.0.0rc6 https://github.com/invoke-ai/InvokeAI

cd InvokeAI
pip install -e .[xformers] --use-pep517 --extra-index-url https://download.pytorch.org/whl/cu121

cd $dir
pip install pyngrok
conda install glib -y

conda deactivate
