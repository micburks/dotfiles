#!/bin/bash
cp build/output/.zshrc ~/.zshrc
mkdir -p ~/.config
cp -R build/output/nvim ~/.config/
