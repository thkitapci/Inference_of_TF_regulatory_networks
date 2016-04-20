
#Analysis before normalization

data=read.table('embryoCountsresult_with_length.txt',sep="\t",header=T)
subdata=data[ ,2:(ncol(data)-1)]
averagereadscount=apply(subdata,2,mean)
ExpressedGenes=apply(subdata>0,2,sum)
plot(x=averagereadscount,y= ExpressedGenes,xlab="Average counts of reads / Sample",ylab="No. genes expressed / Sample",cex.lab=0.9,cex.axis=0.9)

#Analysis after normalization

RPKM=(t(10^9*t(subdata)/apply(subdata,2,sum)))/data$Length
RPKM1=apply(RPKM,2,mean)
ExpressedGenesRPKM=apply(RPKM>0,2,sum)
plot(y=ExpressedGenesRPKM,x= RPKM1,xlab="Average RPKM / Sample",ylab="No. genes expressed / Sample",cex.main=0.9,cex.lab=0.9,cex.axis=0.9)
points(RPKM1[ExpressedGenesRPKM<7500],ExpressedGenesRPKM[ExpressedGenesRPKM<7500],col="red",cex=1,pch=20)
mean(RPKM1[ExpressedGenesRPKM>=7500])
sd(RPKM1[ExpressedGenesRPKM>=7500])

# plot 59 samples after discard 12 samples and keep 7805 genes which were detected in at least 50 samples

samples=RPKM[ ,ExpressedGenesRPKM>7500]
averagegeneexpression=apply(samples,1,mean)
Numberofsampleswheregenesarefound=apply(samples>0,1,sum)
hist(Numberofsampleswheregenesarefound,breaks=50,ylab="No. of genes",xlab=" No. Samples in which genes is mapped",col="gray",cex.lab=0.9,cex.axis=0.9)

samples59=RPKM[ ,apply(RPKM>0,2,sum)>7500]   #---- 15682  59 

genecount=apply(samples59>0,1,sum)     #---15682

Genes_sample59=data.frame(Genes=data$Genes,samples59)      #----- 15682   60

gene=Genes_sample59[rownames(Genes_sample59)[genecount>=50],]   #7805   60

write.table(Genes_50,file="rpkm59_exp50_genes_least_50_samples",sep="\t",quote=F,row.names=F)


# correlation between 14 TFs and 7805 genes

gene=read.table('rpkm59_exp50_genes_least_50_samples.txt',sep="\t",header=T,row.names=1)

tf=read.table('C:/Users/Noha Osman/Desktop/tfselected.txt',header=T,sep="\t",,row.names=1)

cor_genes_TF=cor(t(gene), t(tf))

write.table(cor_genes_TF,file="cor_tf_gene", sep="\t",quote=F)

