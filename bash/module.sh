#!/usr/bin/env bash

# Loads the nessecary modules

MODULES="cmake cuda googletest benchmark autossh mpi/mpich-x86_64 lammps"

if  hash module 2>/dev/null ; then
    for M in $MODULES; do
        modinfo "$M" 2>/dev/null && module load "$M" >/dev/null
    done
fi
