Running the MAFDash singularity package  

singularity exec \
-B /scratch/nousome/:/program/ \
-B /data/CCBR/rawdata/nousome/ccbr1065/Somatic/Somatic/paired_wes/:/data \
/scratch/nousome/mafD.sif Rscript /program/maf.R /data/all.maf /data/out.html
