#Inputs are embryoCountsresult_with_length.txt and TF_names397.txt was obtained from FlyTF.org 

#Output is tfselected.txt -> Expression level of TFs expressed in whole data

data=read.table("embryoCountsresult_with_length.txt",sep="\t",header=T)

subdata=data[ ,2:(ncol(data)-1)]

RPKM=(t(10^9*t(subdata)/apply(subdata,2,sum)))/data$Length

rows=apply(RPKM>0,1,sum)>0

columns=apply(RPKM>0,2,sum)>7500

table=data.frame(data$Genes[rows],RPKM[rows,columns])   #13609   60

TF=read.table("TF_names397.txt",header=F)

A=TF[ ,1]

class(A)

tf=table[table[ ,1]%in%A,]


write.table(tf,file="tfselected.txt",sep="\t",quote=F,row.names=F)
