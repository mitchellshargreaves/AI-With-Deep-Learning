#!/bin/bash
#SBATCH --ntasks=2
#SBATCH --time=00:00:10
#SBATCH -o myfirstjob.out
srun hostname
