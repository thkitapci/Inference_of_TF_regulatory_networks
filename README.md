#Read mapping
Reference genome used for mapping:

ftp://ftp.ensembl.org/pub/release-75/fasta/drosophila_melanogaster/dna/Drosophila_melanogaster.BDGP5.75.dna.toplevel.fa.gz

ftp://ftp.ensembl.org/pub/release-75/gtf/drosophila_melanogaster/Drosophila_melanogaster.BDGP5.75.gtf.gz

# Create count table

    



						   



#pull out the positions of the genes which have correlated values between -1 and 1 with each TF of interest from gtf file

`awk '{if($3=="gene")print;}' Drosophila_melanogaster.BDGP5.75.gtf >result1.txt`

`sed -e 's/\"//g' result1.txt > result.txt`

`tail -n+2 genes_TF.txt |while read line; do grep $line result.txt | awk '{if($3=="gene") print;}' >>position_Genes.txt;done;`

# accessible regions of genes which have correlation with each TF of interest in 5kb window
                             `5kb.pl`
                             
  input file 1: position_Genes.txt file (positions of the genes which have positive and negative correlation with each TF of interest from  Drosophila_melanogaster gtf file).
  
  input file 2:correlated accessible regions file ( the accessible regions of Drosophila_melanogaster developmental stage which we are interested in).
  
   output file: position_accessible_regions_genes_TF.txt file ( positions of accessible regions of genes which have correlation with each TF).

#pull out the fasta sequence for  accessible regions of genes which have correlation with each TF of interest  from reference genome
                            `fastasequence.pl`

    input file 1: Drosophila_melanogaster.BDGP5.75.dna.toplevel.fa (fasta sequence of reference genome)
    
    inputfile 2: position_accessible_regions_genes_TF.txt file
    
    output file : fasta_sequence_accessible_regions_genes_TF.txt  (fasta sequence of accessible regions of genes have correlation with each TF)


#patser program command to get the scores (strength binding) and numbers of binding sites 
`patser-v3e -A a:t 0.53 c:g 0.47 -f fasta_sequence_accessible_regions_genes_TF.txt  -m PWM of each TF of interest -c -li > TF_results_patser_scores.txt`

#Filtering patser output data

 Patser is run using the "-li" option which sets the p-value cut-off based on the sample size adjusted information content.
  
    A: look at the distribution of the scores given by patser then determine the cutoffs of 10% and 5 % tail of score distribution.
    
                                
 
    B: keep the genes in 10% and 5 % tail of score distribution for downstream analysis.


# analysis after patser

A)  count the numbers of binding sites for each gene in 10 and 5 % tail of score distribution with each TF motif (PWM) of interest -consider as number of binding sites 

                                     `count.pl`
                                     
      input file (TF_results_patser_scores_5_10.txt) :  names and scores of the genes in 10 and 5% tail of score distribution
      
      output file (number_binding_sites_TF.txt) : name and numbers of each gene in 10 and 5% tail of score distribution
                             


B) calculate the average of  binding scores for each gene has more than one binding sit in 10 and 5 % tail of score distribution with each TF motif (PWM)of interest --consider as average of strength of TF binding sites 

                                             `average_binding_score.pl`
                     
        input file (TF_results_patser_scores_5_10.txt) :  names and scores of the genes in 10 and 5% tail of score distribution
        
        output file (TF.avg.txt) : name and average strength binding of each gene in 10 and 5% tail of score distribution

C) get genes_name,number of binding sites and average of binding sore for each gene in 10 and 5% tail of score distribution with each TF motif (PWM) of interest

                                     `countnumber_bindingscore.pl`
                                     
              inputfile 1: number_binding_sites_TF.txt
              
              inputfile 2: TF.avg.txt
              
              output file : genes_names_count_average_tf.txt

D) get genes_name , number of binding sites , average of binding sites , co-variation of each gene in 10 and 5% tail of score distribution with each TF motif (PWM) of interest

                              `genes_numbers_score_expression.pl`
                              
                   inputfile 1 : genes_names_count_average_tf.txt 
                   
                  inputfile 2 : expression_covariation_tf_14.txt (expression covariation of each TF of interest with 7805 genes).
                  
                  outputfile : genes_names_count_average_expression_covariation_tf.txt

E)  keep the genes which have more than two binding sites then divide those genes into genes have positive and negative covariation with each TF of interest 

                                    `more_two_binding_sites_negative_positive.pl` 
                                    
                       input file 1 : genes_names_count_average_expression_covariation_tf.txt
                       
                       output file 1: negative.txt ( genes have more than two binding sites and negative covariation with TF)
                       
                       output file 2 : positive.txt (genes have more than two binding sites and positive covariation with TF)

F)  spearman correlations is done by R for positive.txt and negative.txt  to estimate the correlation between the number of binding sites and expressioncovariation as well as between average strength binding and expressioncovariation of each TF of interest.
            
                           # R script (positive.txt)
                           
 data_positive=read.table("positive.txt",sep="\t")

cor.test(data_positive[,2],data_positive[,4] ,method='spearman')  # orrelation between number of binding sites and expressioncovariation

cor.test(data_positive[,3],data_positive[,4] ,method='spearman')   # correlation between average of strength binding and expressioncovariation
        
                        #  R script (positive.txt)

 data_negative=read.table("negative.txt",sep="\t")

 cor.test(data_negative[,2],data_negative[,4] ,method='spearman')  # correlation between number of binding sites and expressioncovariation

 cor.test(data_negative[,3],data_negative[,4] ,method='spearman')  # correlation between average of strength binding and expressioncovariation





