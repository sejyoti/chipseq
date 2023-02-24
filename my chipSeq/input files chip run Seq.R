---
  title: "02_input_files_nextflow_pipeline"
author: "Sejyoti"
date: "2023-02-01"
output:
  html_document:
  code_folding: hide
---
  

# 1. Config File
# first make a new analysis directory

cd D:/Lifebit_nextflow_code/my_chipSeq

# making the .config file
nano nextflow.config
# Paste in the following code into the nextflow.config file

process {
  executor = 'slurm'
  queue = 'short'
  memory = '32 GB'
  maxForks = 10
}


# a design file for chip-seq:
--nano design.csv

--group,replicate,fastq_1,fastq_2,antibody,control


# 3. Shell script

# The shell script is going to contain two parts:
# a) SLURM instructions on how to run the pipeline (memory etc)
# b) The specifics for NF_CORE ChIPseq pipeline

nano run.sh

#!/bin/bash
#SBATCH -p short
#SBATCH --job-name=Hepg2_Pol_test
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=sejyotichakraborty@gmail.com
#SBATCH --output=nextflow.out
#SBATCH --error=nextflow.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=6gb
#SBATCH --time=10:00:00

pwd; hostname; date
echo "Lets do chipseq"

docker pull nfcore/chipseq:1.2.1
module load docker/3.1.1
nextflow run nf-core/chipseq -r 1.2.1 \
-profile docker \
--single_end \
--input "D:\Lifebit nextflow code\my chipSeq\design.csv" \
--fasta "D:\Lifebit nextflow code\my chipSeq\GRCh38.p13.genome.fa" \
--gtf "D:\Lifebit nextflow code\my chipSeq\gencode.v32.annotation.gtf" \
--macs_gsize 3.2e9 \
--blacklist "D:\Lifebit nextflow code\my chipSeq\hg38-blacklist.v2.bed" \
--email sejyotichakraborty@gmail.com \
-resume \
-c nextflow.config


#--single_end option specifies that the input reads are single-end rather than paired-end.

#-profile docker: This selects the docker profile to run the pipeline inside a Docker container.
#--single_end: This specifies that the sequencing data is single-end.
#--input design.csv: This specifies the input file containing the experimental design, which describes how the samples were prepared and sequenced.
#--fasta "D/Lifebit nextflow code/my chipSeq/GRCh38.p13.genome.fa": This specifies the path to the reference genome assembly file in FASTA format.
#--gtf "D/Lifebit nextflow code/my chipSeq/gencode.v32.annotation.gtf": This specifies the path to the genome annotation file in GTF format.
#--macs_gsize 3.2e9: This specifies the effective genome size in base pairs, which is used by the MACS2 software for peak calling.
#--blacklist "D/Lifebit nextflow code/my chipSeq/hg38-blacklist.v2.bed": This specifies the path to the file containing genomic regions that should be excluded from the analysis, such as known problematic regions



#The design file specifies the experimental design, which describes how the samples were prepared and sequenced. The file should have the following columns in this order:
  
#group: The name of the experimental group to which the sample belongs, such as "treated" or "control".
#replicate: A unique identifier for each sample within a group, such as "1" or "2".
#fastq_1: The path to the first read file in FASTQ format for the sample.
#fastq_2: The path to the second read file in FASTQ format for the sample, if the data is paired-end.
#antibody: The name of the antibody used for immunoprecipitation, if any.
#control: The name of the control sample used for normalization and background subtraction, if any.


group,replicate,fastq_1,fastq_2,antibody,control
treated,1,/path/to/treated_rep1_R1.fastq.gz,/path/to/treated_rep1_R2.fastq.gz,H3K4me3,input
treated,2,/path/to/treated_rep2_R1.fastq.gz,/path/to/treated_rep2_R2.fastq.gz,H3K4me3,input
control,1,/path/to/control_rep1_R1.fastq.gz,/path/to/control_rep1_R2.fastq.gz,input,input
control,2,/path/to/control_rep2_R1.fastq.gz,/path/to/control_rep2_R2.fastq.gz,input,input

# Make sure you are in the right directory
cd /path/to/your/directory

# Run the analysis using SLURM
sbatch run.sh

# Track progress
squeue -u <SEJYOTIARNA>
  tail -f nextflow.out

# Cancel a job if needed
scancel -u <SEJYOTIARNA>
  

