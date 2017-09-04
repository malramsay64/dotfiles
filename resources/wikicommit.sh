#!/bin/sh
#
# wikicommit.sh
# Copyright (C) 2017 Malcolm Ramsay <malramsay64@gmail.com>
#
# Distributed under terms of the MIT license.
#

(

today=$(date +%Y-%m-%d)

cd "$HOME/Documents/notes"
git add PhD; git commit -m "PhD update $today"
git add personal; git commit -m "Personal wiki update $today"
git push

cd "$HOME/Documents/notes/personal/diary"
git add *; git commit -m "Diary update $today"
git push

)

