colnames(categories) = c("id","url")
colnames(genre_connection) = c("url1","url2")

derivative = unique(append (as.character(genre_connection$url1), as.character(genre_connection$url2))) 

newcat = ( derivative[!(derivative%in%as.character(categories$url))])
index = length(categories$id)+1

categories = rbind( categories, data.frame(  id = c(index:(index+length(newcat)-1))   ,  url=newcat) )

newderivate = merge(  categories , genre_connection, by.x="url", by.y="url1", )
newderivate = newderivate[,c(2,3)]
colnames(newderivate) = c("id_genre1","url_genre2")
newderivate = merge(  categories , newderivate, by.x="url", by.y="url_genre2", )
newderivate = newderivate[,c(3,2)]
colnames(newderivate) = c("id_genre1","id_genre2")
newderivate = newderivate[order(newderivate$id_genre1),]

write.table(newderivate, file="derivative.tsv", sep="\t", quote=F, row.names=F, col.names=F)

write.table(newderivate, file="instrument.tsv", sep="\t", quote=F, row.names=F, col.names=F)

write.table(newderivate, file="fusiongenre.tsv", sep="\t", quote=F, row.names=F, col.names=F)

write.table(newderivate, file="subgenre.tsv", sep="\t", quote=F, row.names=F, col.names=F)

write.table(newderivate, file="stylistic.tsv", sep="\t", quote=F, row.names=F, col.names=F)
