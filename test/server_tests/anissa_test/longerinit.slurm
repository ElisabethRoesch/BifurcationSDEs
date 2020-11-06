#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=2-23:59:59
#SBATCH --mail-user=anissa.guillemin@unimelb.edu.au
#SBATCH --mail-type=ALL
# Note: SLURM defaults to running jobs in the directory

# Load required modules
module load julia/1.5.1-linux-x86_64

# Launch julia code
julia supercritical_pitchfork_rerun_more_inits.jl

