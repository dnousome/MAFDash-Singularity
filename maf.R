#!/usr/bin/env Rscript
library(dplyr)
library(MAFDash)
library(maftools)

###########Examine
#test1=intersect(annovar_dt$Otherinfo6,filtered_mafdata$dbSNP_RS)
##annovar_dt %>% filter(Otherinfo6 %in% test1 & !is.na(ExAC_ALL))
#annovar_dt %>% filter(Otherinfo6=="rs199942750")
#filtered_mafdata %>% filter(dbSNP_RS=="rs199942750")
##############

args = commandArgs(trailingOnly=TRUE)

print(args)
##Read in MAF file annotated from vcf2maf to prep for MAFDASH
maf_file=args[1]

filtered_mafdata <- filterMAF(maf_file)

new_dt=filtered_mafdata %>% 
  filter(AF<0.001) 
 


print(head(new_dt))


###Run MAFDASH
filtered_maf <- read.maf(new_dt)

tcgacompare_file <- file.path(getwd(),"tcga_compare.png")
png(tcgacompare_file,width=8, height=6, units="in", res=400)
tcgaCompare(filtered_maf,tcga_capture_size = NULL)
dev.off()


custom_onco <- generateOncoPlot(filtered_maf)

#oncoplot(filtered_maf)
customplotlist <- list("summary_plot"=T,
                       "burden"=T,
                       "TCGA Comparison"=tcgacompare_file,
                       "oncoplot"=T,
                       "Annotated Oncoplot"=custom_onco
)

## Filename to output to; if output directory doesn't exist, it will be created
html_filename=file.path(getwd(),args[2])

## Render dashboard
getMAFDashboard(MAFfilePath = filtered_maf,
                plotList = customplotlist,
                outputFileName = html_filename, 
                outputFilePath=getwd(),
                outputFileTitle = "Customized Dashboard")