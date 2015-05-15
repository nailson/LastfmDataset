x = old_category[!(old_category$V2%in%categories$V1),]
x = data.frame( V1=x$V2, V2=c(1511:1647) )
y = rbind(categories,x)
y=y[,c(2,1)]
colnames(y) = c("id","url")



x = merge(musicderivativeFinal, old_category, by.x="V1", by.y="V1", )
colnames(x)=c("oldid","newid","url")
x = x[,c(1,2)]
z = merge(x, y, by.x="oldid", by.y="url", )
