library("DEXSeq")
library(BiocParallel)


changeColName <- function(x){
  str1 <- strsplit(gsub("[^[:alnum:] ]", " ",x), " +")[[1]][10]
  str2 <- gsub("Aligned", "", str1)
  return(str2)
}

source("/N/scratch/syennapu/GENOMICS_PROJECT/Subread_to_DEXSeq/load_SubreadOutput.R")

BPPARAM= MulticoreParam(workers=8)

featurecounts_outdf <- read.delim("/N/scratch/syennapu/GENOMICS_PROJECT/featureCount_output/filtered_featurecounts.out", as.is = T, skip = 1,row.names = NULL)
samples <- colnames(featurecounts_outdf[, 7:ncol(featurecounts_outdf)])

# samp <- data.frame(row.names = samples, 
#                    condition = factor(rep(c("cancer","normal"),times=c(24,29))))

samp <- data.frame(row.names = samples,
                   condition = factor(rep(c("cancer","normal"),times=c(24,29))))

dxd <- DEXSeqDataSetFromFeatureCounts("/N/scratch/syennapu/GENOMICS_PROJECT/featureCount_output/filtered_featurecounts.out",
                                         flattenedfile = "/N/scratch/syennapu/GENOMICS_PROJECT/Subread_to_DEXSeq/gencode_v44_featurecounts.gtf",
                                         sampleData = samp)

genesForSubset <- c("ENSG00000130985.17","ENSG00000117713.21","ENSG00000148400.13","ENSG00000181449.4","ENSG00000125398.8","ENSG00000149948.14",
                    "ENSG00000146648.21","ENSG00000141510.18","ENSG00000133703.14","ENSG00000135679.27","ENSG00000171094.18","ENSG00000164362.21",
                    "ENSG00000105976.16","ENSG00000141736.14","ENSG00000047936.11"," ENSG00000136997.22","ENSG00000165731.21","ENSG00000147889.18",
                    "ENSG00000087460.29","ENSG00000136352.20")

print("Running gene filteration")
dxd = dxd[geneIDs(dxd) %in% genesForSubset,]

print("Running normalization")
dxd = estimateSizeFactors(dxd)

print("Running dispersion")
dxd = estimateDispersions(dxd, BPPARAM=BPPARAM)

print("Running the model")
dxd = testForDEU(dxd, BPPARAM=BPPARAM)

print("Running fc estimation")
dxd = estimateExonFoldChanges(dxd,BPPARAM=BPPARAM,denominator="normal")

print("Running results")
dxd.res <- DEXSeqResults(dxd)

print("Saving rds")
saveRDS(dxd.res,"/N/u/sdlokuge/Carbonate/Documents/Genomics_data_analysis/project/LungCancer_dxd.rds")

print("Done")

