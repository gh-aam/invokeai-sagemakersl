#!/bin/bash

rm -rf ~/.cache/*

df -h | grep -E 'Avail|home'
du -h --max-depth=1 ~
