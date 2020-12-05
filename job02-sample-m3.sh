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

# Start the nvidia-smi command
# nvidia-smi dmon -s pucvt -o DT -d 10 -f nvidia-smi.dmon$1.$(date "+%Y.%m.%d-%H.%M.%S").csv &
nvidia-smi --query-gpu=timestamp,name,utilization.gpu,utilization.memory,memory.total,memory.free,memory.used --format=csv -l 30 -f nvidia-log &

# Get its PID
PID=$!

module purge
module load pytorch/1.6-cuda10
python3 /home/username/finetune_torchvision.py

kill $PID