library("DEXSeq")

## Read the rds file - for all samples (few samples where removed after pca analysis)

dxd_res<- readRDS("/N/scratch/syennapu/GENOMICS_PROJECT/dexseq_results/lungCancer_dxd_allsamples.rds")

table((dxd_res$padj < 0.05) & (dxd_res$log2fold_normal_cancer > log2(1.5)))

dxd_df <- as.data.frame(dxd_res)

signi_exons <- dxd_df[which((dxd_df$padj < 0.05) & (dxd_df$log2fold_normal_cancer > log2(1.5))),]

# signi_dxd <- dxd_res[which((dxd_res$padj < 0.05) & (dxd_res$log2fold_normal_cancer > log2(2))),]

write.csv(dxd_df[,1:68], "DEXSeq_results.csv",row.names = FALSE) 

# DEXSeqHTML( dxd_res, FDR=0.05, color=c("#FF000080", "#0000FF80"),filter=signi_exons$groupID)

plotDEXSeq(dxd_res, FDR = 0.05, "ENSG00000147889.18", legend=TRUE, cex.axis=1.2, cex=1.3, lwd=2, 
           splicing=TRUE, expression=FALSE)

# plotDEXSeq( dxd_res, "ENSG00000171094.18", displayTranscripts=TRUE, legend=TRUE, cex.axis=1.2, cex=1.3, lwd=2 )


# for fc > 1.5 (exons with possible lengths)
# ENSG00000087460.29 - 46,91
# ENSG00000105976.16 - 16
# ENSG00000141736.14 - 3,4,8,80
# ENSG00000147889.18 - 29, 30, 32, 33, 34, 35

# for fc > 2 (exons with possible lengths)
# ENSG00000147889.18 - 29, 30, 32, 33, 34, 35


