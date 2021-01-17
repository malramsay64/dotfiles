#!/bin/bash

# Ensure all directories in config are linked to the ~/.config directory
for dir in $(ls config/); do
    # Use the -s flag to create a symbolic link
    # Use the -i flag to intereactive determine overwriting of links
    ln -si $(pwd)/config/$dir "$HOME"/.config/
done
