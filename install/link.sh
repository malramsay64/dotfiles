#!/usr/bin/env bash

DOTFILES="$HOME/dotfiles"

# Backup files before installation
source "$DOTFILES/install/backup.sh"

echo "Creating symlinks"

linkables=$( find -H "$DOTFILES" -name '*.symlink' -not -regex ".*\.git.*")
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
                    link=false
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
    if [ $link == true ]; then
        echo "Creating symlink for $file"
        ln -s $file $target
    fi
done

linkconfig=$( find -H "$DOTFILES" -name '*.configlink' -not -regex ".*\.git.*")
for file in $linkconfig; do
    link=false
    target="$HOME/.config/$(basename $file '.configlink' )"
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
                    link=flase
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
