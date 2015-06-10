
typeof(dataset$V3)

subsetting <- data.frame(id_user=c(), V1=c() ,weight=c(), normalized=c())
  
for(user in unique(dataset$id_user)){
  
  new_subsetting2 =  dataset[dataset$id_user==user,]  
  #print(user)
  new_subsetting2$normalized = sapply(data.frame( weight=new_subsetting2$weight), normalize)
                                      
  subsetting = rbind(subsetting,new_subsetting2 ) 

}
write.table(subsetting, file="dataset_normalized.tsv", sep="\t", row.names=F, col.names=F, quote=F)


#normalize <- function(x){(x-min(x))/(max(x)-min(x))}

normalize <- function(x){(x/(sum(x)))}

sapply(data.frame(weight=dataset[c(1:10),c(3)]), normalize2 )


apply(c(1:100), normalize )
