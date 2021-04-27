Running the MAFDash singularity package  
If using in Biowulf, be sure to run an interactive slurm session


In singularity, bind paths correctly to the correct directory for the MAF file for input and the output html file

module load singularity

singularity exec \
-B /path/to/maf_and_htmloutput:/data \
/scratch/nousome/mafD.sif Rscript /program/maf.R /data/all.maf /data/out.html
