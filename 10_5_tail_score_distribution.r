score_TF=read.table('',sep="\t")

score=data_TF["V2"]

TF_Score_from_PATSER=as.matrix(score)

hist(TF_Score_from_PATSER)

quantile(score[,],c(0.90)) 

quantile(score[,],c(0.95))  

abline(v=c(90,95),col=c("blue","red"))

names=c("10% [ ]","5% [ ]" )

legend('topright',names,fill=c('blue','red'), bty='n',cex=.75)
