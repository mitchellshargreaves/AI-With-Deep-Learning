#!/bin/bash
#SBATCH --ntasks=2
#SBATCH --mem=3500MB
#SBATCH -o myfirstjob.out
#SBATCH --partition comp
srun hostname
