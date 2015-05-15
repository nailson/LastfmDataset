x = old_category[!(old_category$V2%in%categories$V1),]
x = data.frame( V1=x$V2, V2=c(1511:1647) )
y = rbind(categories,x)
y=y[,c(2,1)]
colnames(y) = c("newid","url")

write.table(y, file = "categories.tsv", sep = "\t",  row.names = FALSE, col.names = FALSE)

mapp = merge(old_category, y, by.x="V2", by.y="url", )[,c("newid","V1")]
colnames(mapp)=c("newid","oldid")

newmusicderivativeFinal = merge(musicderivativeFinal, mapp, by.x="V1", by.y="oldid")[,c("V2", "newid")]
colnames(newmusicderivativeFinal) = c("V2","V1")

newmusicderivativeFinal = merge(musicderivativeFinal, mapp, by.x="V2", by.y="oldid")[,c("V1", "newid")]

newmusicderivativeFinal = newmusicderivativeFinal[order(newmusicderivativeFinal$V1),]

write.table(newmusicderivativeFinal, file = "musicderivative.tsv", sep = "\t",  row.names = FALSE, col.names = FALSE)

newmusicSupergenreFinal = merge(musicSupergenreFinal, mapp, by.x="V1", by.y="oldid")[,c("V2", "newid")]
colnames(musicSupergenreFinal) = c("V2","V1")

newmusicSupergenreFinal = merge(musicSupergenreFinal, mapp, by.x="V2", by.y="oldid")[,c("V1", "newid")]

write.table(newmusicSupergenreFinal, file = "musicSupergenre.tsv", sep = "\t",  row.names = FALSE, col.names = FALSE)


x = merge(musicderivativeFinal, old_category, by.x="V1", by.y="V1", )
colnames(x)=c("oldid","newid","url")
x = x[,c(1,2)]
z = merge(x, y, by.x="oldid", by.y="url", )
