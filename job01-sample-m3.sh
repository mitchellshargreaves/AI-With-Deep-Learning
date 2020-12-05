#!/bin/bash
#SBATCH --job-name=pytorch
#SBATCH --account=vf68
#SBATCH --nodes=1
#SBATCH --ntasks=6
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:P4:1
#SBATCH --partition=desktop
#SBATCH --mem=55G
#SBATCH --qos=desktopq
#SBATCH --reservation=training-ml-20201209

module purge
module load pytorch/1.6-cuda10

python3 /path/to/finetune_torchvision.py