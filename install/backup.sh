#!/usr/bin/env bash

# Backup all dotfiles being replaced into $HOME/.dotfiles-backup

BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y-%m-%d)"
DOTFILES="$HOME/dotfiles"

echo "Creating backup directory at $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

linkables=$( find -H "$DOTFILES" -name '*.symlink' )

for file in $linkables; do
    filename=".$(basename $file '.symlink' )"
    target="$HOME/$filename"
    if [ -e $target ]; then
        echo "backing up $filename"
        cp -rL "$target" "$BACKUP_DIR"
    fi
done
