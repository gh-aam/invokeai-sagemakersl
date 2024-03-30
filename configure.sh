#!/bin/bash

eval "$(conda shell.bash hook)"
conda activate invokeai

mkdir -p /tmp/invokeai/models
mkdir -p ~/invokeai
if ! test -e ~/invokeai/models
then
    ln -s /tmp/invokeai/models ~/invokeai/
fi

invokeai-configure --root_dir ~/invokeai --yes --default_only --skip-sd-weights --no-full-precision

rm -rf ~/.cache/huggingface/hub/*

conda deactivate
