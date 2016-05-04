#!/usr/bin/env bash

# Loads the nessecary modules

MODULES="cmake cuda googletest benchmark autossh mpi/mpich-x86_64 lammps"

if  hash module 2>/dev/null ; then
    for M in $MODULES; do
        [[ $(module avail "$M" 2>&1 | wc -c) > 0 ]] && module load "$M" >/dev/null
    done
fi
