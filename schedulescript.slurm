#!/bin/bash

# SBATCH --partition=bio      # partition name. Eg. Debug, bio, bigmem
# SBATCH --job-name=genomic-snakemake      # job name
# SBATCH --nodes=4               # number of nodes allocated for this job
# SBATCH --cpus-per-task=4       # number OpenMP Threads per process
# SBATCH --time=08:00:00         # total run time limit ([[D]D-]HH:MM:SS)
# SBATCH --mem=32G
##The above line and this  will be ignored by Slurm
# Get email notification when job begins, finishes or fails
# SBATCH --mail-type=END,FAIL         # type of notification: BEGIN, END, FAIL, ALL
# SBATCH --mail-user=freemanoparaocha@gmail.com   # e-mail address
# SBATCH --chdir=<working directory>
# SBATCH --export=all
# SBATCH --output=slurm-final-output # where STDOUT goes
# SBATCH --error=slurm-error-output # where STDERR goes

source ~/.bashrc

WORKDIR=/fedgenhome/rotimi/projects/BWMS
SNAKEFILE=/fedgenhome/rotimi/projects/BWMS/workflow

cd "$WORKDIR" || exit 1

source venv/bin/activate

cd "$SNAKEFILE" || exit 1

echo "Running Snakemake workflow in $SNAKEFILE"

snakemake --cores all

    # --use-conda \
    # --rerun-incomplete \
    # --cores all \

# to run the file 
# sbatch schedulescript.slurm
