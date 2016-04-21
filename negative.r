 data_negative=read.table("negative.txt",sep="\t")

 cor.test(data_negative[,2],data_negative[,4] ,method='spearman')  # correlation between number of binding sites and expressioncovariation

 cor.test(data_negative[,3],data_negative[,4] ,method='spearman')  # correlation between average of strength binding and expressioncovariation

