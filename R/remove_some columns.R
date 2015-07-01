allItem_Category_TAGS <- read.delim("~/Documentos/Mestrado/Git/mestrado_UFCG/java workspace/DiversificationAlgorithms/data/lastfm/allItem_Category_TAGS.tsv")

x = colnames(allItem_Category_TAGS)[colnames(allItem_Category_TAGS)!="User"]

y = colSums(allItem_Category_TAGS[,x], )

y1 = data.frame(y)
y1$rownames = row.names(y1)


z =data.frame( y1[order(-y1$y),])

head(z$rownames,2000)

x = allItem_Category_TAGS[ , head(z$rownames,2000)]

write.table(x, file="allItem_Category_TAGS.tsv", col.names= T, row.names=F, sep="\t")


allItem_Category = cbind(allItem_Category, allItem_Category_TAGS[,c("User")])
write.table(allItem_Category, file="allItem_Category_TAGS.tsv", col.names= T, row.names=F, sep="\t")
