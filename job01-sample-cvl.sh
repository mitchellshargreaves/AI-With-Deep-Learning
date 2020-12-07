#!/bin/bash
#SBATCH --job-name=pytorch
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=3.5G
#SBATCH --partition=desktop
#SBATCH --account=vf68

module purge
module load pytorch/1.6-cuda10

python3 /path/to/finetune_torchvision.py
