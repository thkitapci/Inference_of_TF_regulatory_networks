#Read mapping
Reference genome used for mapping:

ftp://ftp.ensembl.org/pub/release-75/fasta/drosophila_melanogaster/dna/Drosophila_melanogaster.BDGP5.75.dna.toplevel.fa.gz

ftp://ftp.ensembl.org/pub/release-75/gtf/drosophila_melanogaster/Drosophila_melanogaster.BDGP5.75.gtf.gz

# Combine 25 crosses with biological replicates


perl [`embryoCountscript_combination.pl`](https://github.com/thkitapci/Inference_of_TF_regulatory_networks/blob/master/embryoCountscript_combination.pl)

#R script
						   
rscript.r


#pull out the positions of the genes which have correlated values between -1 and 1 with each TF of interest from gtf file

`awk '{if($3=="gene")print;}' Drosophila_melanogaster.BDGP5.75.gtf >result1.txt`

`sed -e 's/\"//g' result1.txt > result.txt`

`tail -n+2 allgenes_TF.txt |while read line; do grep $line result.txt | awk '{if($3=="gene") print;}' >>position_Genes.txt;done;`

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





