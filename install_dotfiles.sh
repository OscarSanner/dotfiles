#!/bin/bash

# Define source directories
FONT_DIRS=("fonts/IBMPlexMono" "fonts/JetbrainsNerd" "fonts/SourceCodeProNerd")
CONFIG_DIRS=("kitty" "i3" "nvim" "scripts" "polybar")
XRESOURCES_FILE=".Xresources"

# Define target directories
FONTS_TARGET="$HOME/.local/share/fonts"
CONFIG_TARGET="$HOME/.config"

# Function to compare and copy files if different
copy_if_different() {
    local src=$1
    local dest=$2

    if [ -e "$dest" ]; then
        if diff -q "$src" "$dest" > /dev/null; then
            echo "No changes in $dest, skipping."
        else
            echo "File $dest differs from source $src."
            read -p "Do you want to overwrite it? (y/n) " answer
            if [ "$answer" == "y" ]; then
                cp "$src" "$dest"
                echo "Overwritten $dest."
            else
                echo "Skipped $dest."
            fi
        fi
    else
        cp "$src" "$dest"
        echo "Copied $src to $dest."
    fi
}

# Function to copy fonts
copy_fonts() {
    echo "Copying fonts..."
    mkdir -p "$FONTS_TARGET"

    for font_dir in "${FONT_DIRS[@]}"; do
        if [ -d "$font_dir" ]; then
            echo "Copying $font_dir to $FONTS_TARGET"
            for font_file in "$font_dir"/*; do
                target_file="$FONTS_TARGET/$(basename "$font_file")"
                copy_if_different "$font_file" "$target_file"
            done
        else
            echo "Directory $font_dir not found."
        fi
    done
}

# Function to copy config files
copy_configs() {
    echo "Copying config files..."

    for config_dir in "${CONFIG_DIRS[@]}"; do
        if [ -d "$config_dir" ]; then
            echo "Copying $config_dir to $CONFIG_TARGET"
            mkdir -p "$CONFIG_TARGET/$config_dir"
            for config_file in "$config_dir"/*; do
                target_file="$CONFIG_TARGET/$config_dir/$(basename "$config_file")"
                copy_if_different "$config_file" "$target_file"
            done
        else
            echo "Directory $config_dir not found."
        fi
    done
}

# Function to copy .Xresources
copy_xresources() {
    if [ -f "$XRESOURCES_FILE" ]; then
        echo "Copying $XRESOURCES_FILE to $HOME"
        target_file="$HOME/$XRESOURCES_FILE"
        copy_if_different "$XRESOURCES_FILE" "$target_file"
    else
        echo "$XRESOURCES_FILE not found."
    fi
}

# Main function
main() {
    copy_fonts
    copy_configs
    copy_xresources
    echo "Done!"
}

# Execute the main function
main
