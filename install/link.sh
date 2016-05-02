#!/usr/bin/env bash

DOTFILES="$HOME/dotfiles"

# Backup files before installation
source "$DOTFILES/install/backup.sh"

echo "Creating symlinks"

linkables=$( find -H "$DOTFILES" -name '*.symlink' )
for file in $linkables; do
    link=false
    target="$HOME/.$(basename $file '.symlink')"
    if [ -e $target ]; then
        echo -n "~${target#$HOME} already exists... Replace {y/n}: "
        read replace
        loop=0
        while [ $loop -lt 3 ]; do
            loop=$[$loop+1]
            case $replace in
                y)
                    link=true
                    rm -r $target
                    break
                   ;;
                n)
                    break
                    ;;
                *)
                    echo -e "\nReplace {y/n}: "
                    read replace
                    ;;
            esac
        done
    else
        link=true
    fi
    if [ $link ]; then
        echo "Creating symlink for $file"
        ln -s $file $target
    fi
done


