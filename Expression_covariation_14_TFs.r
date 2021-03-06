 #input files are tfselected.txt and gene_id of 14 TFs of interest to pull out expression levels of these TFs 
 
 
 tf=read.table("tfselected.txt",sep="\t",header=T)
 
gene_id_14_TFs=c("FBgn0000166","FBgn0001180","FBgn0000251","FBgn0001150","FBgn0001320","FBgn0001325","FBgn0003720","FBgn0000606","FBgn0001168","FBgn0003300","FBgn0000577","FBgn0003448","FBgn0003900","FBgn0001077")

B=tf$Genes %in% gene_id_14_TFs
TF14=tf[B,]
write.table(TF14,file="expression_level_14_TFs", row.names=F, sep="\t",quote=F)

#get expression covariation of 14 TFs and 7805 genes

   gene=read.table("rpkm59_exp50_genes_least_50_samples.tab",sep="\t",header=T,row.names=1)

    tf14=read.table("expression_level_14_TFs",header=T,sep="\t",,row.names=1)
    
    correlation_TF_14=cor(t(gene), t(tf14),method='spearman')
    
    write.table(correlation_TF_14,file="expression_covariation_tf_14.txt", sep="\t",quote=F)

