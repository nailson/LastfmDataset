dataset <- read.delim("../new data/dataset.tsv", header=F)

dataset = artist_genre_final
colnames(dataset) = c("id_user", "V1", "weight")

typeof(dataset$weight)

subsetting <- data.frame(id_user=c(), V1=c() ,weight=c(), normalized=c())
  
for(user in unique(dataset$id_user)){
  
  new_subsetting2 =  dataset[dataset$id_user==user,]  
  #print(user)
  new_subsetting2$normalized = sapply(data.frame( weight=new_subsetting2$weight), normalize)
                                      
  subsetting = rbind(subsetting,new_subsetting2 ) 

}
write.table(subsetting[,c(-3)], file="artist_origin__norm.tsv", sep="\t", row.names=F, col.names=F, quote=F)

#normalize <- function(x){(x-min(x))/(max(x)-min(x))}

normalize <- function(x){(x/(sum(x)))}

sapply(data.frame(weight=dataset[c(1:10),c(3)]), normalize2 )


apply(c(1:100), normalize )
