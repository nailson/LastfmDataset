
boxplot(allItem_ILS_Dataset$ILS_5)
summary(allItem_ILS_Dataset$ILS_5)


plot(sort(allItem_ILS_Dataset$ILS_5))

merged_ILS = merge(allItem_ILS_Dataset, allItem_ILS_BPRMF, by.x="User", by.y="User", )
colnames(merged_ILS) = c("User", "Profile_ILS", "BPFMF_ILS")
merged_ILS = merged_ILS[order(-merged_ILS$BPFMF_ILS),]

plot(sort(merged_ILS[,3]),col="red")
par(new=TRUE)

summary(merged_ILS[,2])
boxplot(merged_ILS[,2], outline = F)
summary(merged_ILS[,3])
boxplot(merged_ILS[,3], outline = F, )

boxplot(x = as.list(as.data.frame(merged_ILS[,c(2,3)])), outline = F , main="User Profile and BPRMF recommendation ILS (Tags)", ylab="ILS@20")

barplot(sort(allItem_ILS_Dataset$ILS_5, decreasing = T), horiz = T, )


ggplot(allItem_ILS_Dataset, aes(y=(ILS_5), x = factor(allItem_ILS_Dataset$User)) ) + geom_bar(stat='identity') + coord_flip()

<<<<<<< HEAD
=======
barplot(sort(allItem_ILS_Dataset$ILS_5, decreasing = T), horiz = T, )


ggplot(allItem_ILS_Dataset, aes(y=(ILS_5), x = factor(allItem_ILS_Dataset$User)) ) + geom_bar(stat='identity') + coord_flip()

>>>>>>> 51469def568e75bc6c65bcba0b6eff387ef1d876
qplot(x=c(1:8049), y=allItem_ILS_Dataset$ILS_5, 
      data=means, geom="bar", stat="identity",
      position="dodge")