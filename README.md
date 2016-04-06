#Read mapping
Reference genome used for mapping:

ftp://ftp.ensembl.org/pub/release-75/fasta/drosophila_melanogaster/dna/Drosophila_melanogaster.BDGP5.75.dna.toplevel.fa.gz

ftp://ftp.ensembl.org/pub/release-75/gtf/drosophila_melanogaster/Drosophila_melanogaster.BDGP5.75.gtf.gz

# combination of 25 crosses have biological replicates 


perl [`embryoCountscript_combination.pl`](https://github.com/thkitapci/Inference_of_TF_regulatory_networks/blob/master/embryoCountscript_combination.pl)

#R script
						   
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
#pull out the positions of the genes which have correlated values between -1 and 1 with each TF of interest from gtf file

`awk '{if($3=="gene")print;}' Drosophila_melanogaster.BDGP5.75.gtf >result1.txt`

`sed -e 's/\"//g' result1.txt > result.txt`

`tail -n+2 allgenes_bicoid.txt |while read line; do grep $line result.txt | awk '{if($3=="gene") print;}' >>position_Genes.txt;done;`

# accessible regions of genes in 5kb window
`perl 5kb_1.pl`  (input files are genes which have positive and negative correlation with 14 TFs (position_Genes) & correlated accessible regions)

output of perl 5kb_1: accessible_regions_TF

#pull out the sequence of correlated accessible regions from reference genome
`perl fastasequence.pl` (input files are fasta sequence of reference genome & accessible regions of 14 TFs output file is results_bicoid.txt


#patser program example for bicoid (similarly for others)
`patser-v3e -A a:t 0.53 c:g 0.47 -f results_bicoid.txt -m BCD_Fly_Reg -c -li > bicoid_patser_results_Fly_Reg`

#Filtering patser output

`blabla` Patser is run using the "-li" option which sets the p-value cut-off based on the sample size adjusted information content. Then we look at the distribution of the scores given by patser (insert a histogram) and take only 10% tail.


# analysis after patser

A) `perl count.pl` count the numbers of each gene has p value less than -6---consider as number of binding sites output:count_bicoid_genes.txt

B)`perl average_binding_score.pl` calculate the average of  binding scores for each gene has p value less than -6 --consider as average of strength of TF binding sites output file: bicoid_genes_average.txt 

C)`perl countnumber_bindingscore.pl` get genes_name,number of binding sites , average of binding sore for each gene has p value less than -6 output file: genes_count_average_bicoid.txt

D)`perl genes_numbers_score_expression.pl` get genes_name , number of binding sites , average of binding sites , co-variation of each gene has p value less than -6 output file:genes_count_average_expression_bicoid

E) `perl more_two_binding_sites_negative_positive.pl` keep the genes which have more than binding sites then divide the data into positive and negative covariation output files : negative_201_bicoid_492 & positive_291_bicoid_492

F) two spearman correlations are done R for each TFs (positive and negative covariation). one between covariation and number of binding sites and another one between covariation and average of binding score

# R script 
data_positive=read.table('C:/Users/Noha Osman/Desktop/positive_201_bicoid_492.txt',sep="\t")

cor.test(data_positive[,2],data_positive[,4] ,method='spearman')  # correlation of number of binding sites

cor.test(data_positive[,3],data_positive[,4] ,method='spearman')   # correlation of average of strength binding

data_negative=read.table('C:/Users/Noha Osman/Desktop/negative_291_bicoid_492.txt',sep="\t")

cor.test(data_negative[,2],data_negative[,4] ,method='spearman')

cor.test(data_negative[,3],data_negative[,4] ,method='spearman')





