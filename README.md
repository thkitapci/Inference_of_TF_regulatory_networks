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

`tail -n+2 genes_TF.txt |while read line; do grep $line result.txt | awk '{if($3=="gene") print;}' >>position_Genes.txt;done;`

# accessible regions of genes which have correlation with each TF of interest in 5kb window
                             `5kb.pl`
  input file1 : position_Genes file which has positions of the genes which have positive and negative correlation with each TF of interest from  Drosophila_melanogaster gtf file.
  
  input file2 :correlated accessible regions file has the accessible regions of Drosophila_melanogaster developmental stage which we are interested in.
  
   output file: position_accessible_regions_genes_TF file has positions of accessible regions of genes which have correlation with each TF

#pull out the fasta sequence for  accessible regions of genes which have correlation with each TF of interest  from reference genome
`perl fastasequence.pl` (input files are Drosophila_melanogaster.BDGP5.75.dna.toplevel.fa (fasta sequence of reference genome) and position_accessible_regions_genes_TF.txt (positions of accessible regions of genes)

                          output file is fasta_sequence_accessible_regions_genes_TF.txt


#patser program command to get the scores (strength binding) and numbers of binding sites 
`patser-v3e -A a:t 0.53 c:g 0.47 -f fasta_sequence_accessible_regions_genes_TF.txt  -m PWM of each TF of interest -c -li > TF_results_patser_scores`

#Filtering patser output data

 Patser is run using the "-li" option which sets the p-value cut-off based on the sample size adjusted information content. Then we look at the distribution of the scores given by patser  and take  10% and 5 % tail of score distribution.


# analysis after patser

A) `count.pl` count the numbers of binding sites of each gene in 10 and 5 % tail of score distribution with TF motif (PWM) -consider as number of binding sites 

      input file (TF_results_patser_scores) :  names and scores of the genes in 10 and 5% tail of score distribution
      output file (number_binding_sites_TF) : name and numbers of each gene in 10 and 5% tail of score distribution
                             


B)`average_binding_score.pl` calculate the average of  binding scores for each gene has more than one binding sit in 10 and 5 % tail of score distribution with TF motif (PWM) --consider as average of strength of TF binding sites 
                     
        input file (TF_results_patser_scores) :  names and scores of the genes in 10 and 5% tail of score distribution
        output file (TF.avg) : name and average strength binding of each gene in 10 and 5% tail of score distribution

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





