#!/bin/bash
#SBATCH --job-name=pytorch
#SBATCH --account=training
#SBATCH --time=01:00:00
#SBATCH --mem=8G
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:K1:1
#SBATCH --partition=m3f

module purge
module load pytorch/1.6-cuda10

python3 /path/to/finetune_torchvision.py
