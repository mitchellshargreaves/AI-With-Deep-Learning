#!/usr/bin/python
#SBATCH --ntasks=2
#SBATCH --time=00:00:10
#SBATCH -o myfirstpyjob.out
# This isn't actually used in teaching, 
# But I've included it here for curious people
# It turn out you can write a slurm script in any language you like
# As long as it uses # as a comment character and does the #! trick on the first line
# I'm not sure I recomend this, since you loose a lot of control over versions etc
# But its theoritically possible
import sys
print(sys.version)
