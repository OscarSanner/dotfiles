#!/bin/bash

cp -r ~/.config/nvim/ .
cp ~/.Xresources .
cp -r ~/.config/i3/ .
cp -r ~/.config/kitty/ .
cp -r ~/.config/scripts/ .
cp -r ~/.config/polybar/ .

mkdir -p ./fonts/JetbrainsNerd
mkdir -p ./fonts/IBMPlexMono
mkdir -p ./fonts/SourceCodeProNerd

cp ~/.local/share/fonts/JetbrainsNerd/* ./fonts/JetbrainsNerd/ 
cp ~/.local/share/fonts/IBMPlexMono/* ./fonts/IBMPlexMono/
cp ~/.local/share/fonts/SourceCodeProNerd/* ./fonts/SourceCodeProNerd/
