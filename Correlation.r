# correlation between tfselected.txt (397 TFs) and 7805 genes (distribution of input files is normal )

gene=read.table("rpkm59_exp50_genes_least_50_samples.tab",sep="\t",header=T,row.names=1)

tf=read.table("tfselected.txt",header=T,sep="\t",,row.names=1)

cor_genes_TF=cor(t(gene), t(tf) ,method='spearman')

write.table(cor_genes_TF,file="cor_tf_gene.tab", sep="\t",quote=F)

