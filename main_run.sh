#!/bin/bash
#PBS -o main_run.dat
#PBS -e main_run.err
#PBS -N main_run
#PBS -l mem=20gb,walltime=100:00:00

module add matlab
cd /project/vilalta/AE_UH/

matlab  main_run.m "1"
