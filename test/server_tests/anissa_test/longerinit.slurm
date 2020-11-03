#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --time=01:00:00
#SBATCH --mem-per-cpu=2048
# Note: SLURM defaults to running jobs in the directory

# Load required modules
module load julia/1.5.1-linux-x86_64

# Launch julia code
julia supercritical_pitchfork_rerun_more_inits.jl

