% HPC for AI/ML
% Chris Hines
% 20201207

---

## Hello

This is an ML specific digest of

https://docs.massive.org.au

help@massive.org.au

---

## Whats a Cluster/HPC?

Most modern HPC are Clusters.

* Group of computers
* NOT one fast computer

many tasks NOT one fast task

Most AI tasks decompose
BUT you have to do the work

---

## Other bits about a Cluster

Usually:

* Shared filesystem (you don't need to copy you files between nodes)
* Shared Money (pool resources to buy more nodes, but you have to share them)
* Scheduler (takes care of making sure everyone gets a turn)

---

## Schedulers: Bane or Salvation?

Ask for what you want. 

You will get it WHEN its available.

Pro: Don't run out of RAM due to another user

Con: If you run over your job will die

Pro: Exclusive CPU, code should take the same time

Con: If you run over your job will die

Pro: If you're not using it, someone else is 

  * better economics 
  * bigger cluster 
  * faster research

---

## Accessing the cluster

* Terminal/Command line 
* VNC Server (aka Remote Desktop)
* Jupyter Lab

---

## Exercise

Open
[https://training.cloud.cvl.org.au](https://training.cloud.cvl.org.au)

* Select Login in -> Training
* Login with AAF or Google
* Select Terminal
* Click Run on Login Node

---

## Requesting Resources

* Slurm for scheduling
* scripts have a series #SBATCH "comments" at the begining
* The comments tell slurm what resources we want

## Exercise

Run the following commands in the terminal

```
git clone $gitsource$
cd $gitdir$
cat $firstscript$
sbatch $firstscript$
squeue -u $$USER
sacct -j <jobid>
sacct -l -j <jobid>
sacct --format=User,JobID,Jobname,partition,state,time,start,end,elapsed,MaxRss,MaxVMSize,nnodes,ncpus,nodelist,CPUTime -j  <jobid>
```

The job should run extremly quickly

The `sacct` commands really only make sense after the job is completed

---

<div>
<div class='left' style='float:left;width:48%'>

### Resources on M3

```
#SBATCH --job-name=pytorch 
#SBATCH --account=vf68 
#SBATCH --nodes=1 
#SBATCH --ntasks=6 
#SBATCH --cpus-per-task=1 
#SBATCH --gres=gpu:P4:1 
#SBATCH --mem=55G 
#SBATCH --partition=desktop
#SBATCH --qos=desktopq
```
</div>
<div class='right' style='float:right;width:48%'>
### Resources on CVL@UWA

```
#SBATCH --job-name=pytorch
#SBATCH --account=vf68
#SBATCH --nodes=1
#SBATCH --ntasks=6
#SBATCH --cpus-per-task=1

#SBATCH --mem=40G
#SBATCH --partition=desktop


```
</div>
</div>

Different clusters specify their resources in slightly different ways.

M3 has multiple varietys of GPU and you need to request exactly what you want

CVL@UWA is used primarily for Remote Desktop (i.e. vis programs) so the GPUs are managed differently

CVL@UWA has less RAM

---

## Software on a Cluster

Reproducibility is paramount

We will almost never remove an old version of software

Use the `module load` command to select the version you want

---

## Exercise

Try the following commands the terminal

```
module avail 
module avail pytorch
module load pytorch/1.6-cuda10
python -c "import torch ; print(torch.__version__)"
module unload pytorch
python -c "import torch ; print(torch.__version__)"
```

---

## Software on a Cluster (pt 2)

The module command has overlap with

1. conda
2. python virtual envs
3. Using containers

Sometimes its more convenient to use a different version mechanism

Sometimes you need to compose a workflow from multiple pieces of software

Sometimes you want a single environment with every version fixed.

We don't always get it right so ... help@massive.org.au 

---

## Exercise

* Switch tabs back to the $site$ tab
* Acknowledge the dialog
* Click Jupyter Lab
* Click Launch
* When its avilable Click Connect
* Browse to and Open $resnet_notebook$
* Select Run -> "run all cells"

Notice the time to run each epoch

You'll probably want to stop execution at this point

---

## An aside

That dialog you dismissed is a limitation of the proxy service translating connections from a HTTPS connection into the cluster. 

If you use another method of connecting to a cluster (like ssh tunnels) you wouldn't even see this.

## Resources on the cluster

Your Jupyter is on 1 CPU and 4GB RAM

Post-training use more resources (including GPU)

We are teaching scripts etc not Jupyter

---

## Converting Jupyter Notebooks to Scripts

Jupyter Notebooks (ipynb files) include plots and graphs

Scripts can't plot (can save though)

Jupyter can convert ipynb to script but you must remove bits like plots

---

## Exercise

Go back to the notebook

Next comment out ploting cell 

open a new Jupyter terminal (file->new->terminal) and run 

* Don't use the exiting terminal!!!

```
jupyter nbconvert --to script $resnet_notebook$
export EPOCHS=1 ; python3 $resnet_py$
```

---

## Another aside

The jupyter terminal is slightly different than the terminal you started from the main screen

* The jupyter terminal is inside a container environment. The jupyter command is present 
* The terminal on the mainscreen is outside the container environment. The sbatch command is present

In general jupyter doesn't have to be installed in a container. If its not, then the two terminals will be equivalent (except for what modules might be loaded)

---

## Interactive Vs Non-Interactive

Everything so far has been Interactive:

You requested Jupyter

You waited for it to be available and connected

You stared running cells/scripts

What happens when you want BIG resources? You wait in a queue

---

## Exercise

Using the terminal (not the jupyter terminal)
```
cat $resnet_gpu_slurm$
sbatch $resnet_gpu_slurm$
squeue
```
notice the job number
try
```
sacct -j <jobnumber>
cat slurm-<jobnumber>.out
```
Check the time per epoch. Was it faster than previously?

Notice that $resnet_gpu_slurm$ sets an environment variable for EPOCH

---

## Checking performance

Is this as fast as it gets?

Whats the limiting factor?

Compare CPU and GPU usage

---

## Exercise

1. Use sacct --format=start,end,CPUTime -j <jobid>
2. $resnet_gpu_slurm$ produced a csv file of GPU usage. Plot it

---

## Performance

![GPU utilisation](util.png)

* The GPU utilisation never goes over 50%
* There are two clear phases
  * Freezing most layers and training the output 
  * Unfreezing all layers
* 10 Epochs in each phase, you can see  10 dips in the second phase (your epochs=5)
* The CPU util is 6 times the total time. 
  * There were 6 CPUs. 
  * AFAIK pytorch always uses 100% of all CPUs

