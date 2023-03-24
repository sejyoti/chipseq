#!/usr/bin/env Rscript

library(processx)

cmd <- c(
  "#!/bin/bash",
  "#SBATCH -p short",
  "#SBATCH --job-name=Hepg2_Pol_test",
  "#SBATCH --mail-type=END,FAIL",
  "#SBATCH --mail-user=sejyotichakraborty@gmail.com",
  "#SBATCH --output=nextflow.out",
  "#SBATCH --error=nextflow.err",
  "#SBATCH --nodes=1",
  "#SBATCH --ntasks=1",
  "#SBATCH --mem=6gb",
  "#SBATCH --time=10:00:00",
  "",
  "pwd; hostname; date",
  "echo \"Lets do chipseq\"",
  "",
  "docker pull nfcore/chipseq:1.2.1",
  "module load docker/3.1.1",
  "nextflow run nf-core/chipseq -r 1.2.1 \\",
  "-profile docker \\",
  "--single_end \\",
  "--input \"D:\\Lifebit nextflow code\\my chipSeq\\design.csv\" \\",
  "--fasta \"D:\\Lifebit nextflow code\\my chipSeq\\GRCh38.p13.genome.fa\" \\",
  "--gtf \"D:\\Lifebit nextflow code\\my chipSeq\\gencode.v32.annotation.gtf\" \\",
  "--macs_gsize 3.2e9 \\",
  "--blacklist \"D:\\Lifebit nextflow code\\my chipSeq\\hg38-blacklist.v2.bed\" \\",
  "--email sejyotichakraborty@gmail.com \\",
  "-resume \\",
  "-c nextflow.config"
)

# run the command
processx::run_command(cmd, echo = TRUE)
