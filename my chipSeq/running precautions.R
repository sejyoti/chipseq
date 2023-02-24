First we need to know how to run jobs, check on them and most importantly cancel them!
  
  *******************************************
  Running and Checking on slurm jobs
*******************************************
  
  First thing we want to do is "run" a .sh file. Since we set this up in SBATCH we
simply type:
  
  Don't run yet though
```{BASH run.sh}
sbatch run.sh
```
This will have sbatch send the scripts in the run.sh file to slurm to run them. 


--- what jobs are you running? You often want to see what job is running how long it is taking and other aspects. To that end we can use 'squeue' to see what is running
