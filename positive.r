data_positive=read.table("positive.txt",sep="\t")

cor.test(data_positive[,2],data_positive[,4] ,method='spearman')  # orrelation between number of binding sites and expressioncovariation

cor.test(data_positive[,3],data_positive[,4] ,method='spearman')   # correlation between average of strength binding and expressioncovariation
