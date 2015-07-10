
allItem_ILS_Dataset = allItem_ILS_Test
allItem_ILS_BPRMF = allItem_ILS_KNN

boxplot(allItem_ILS_Dataset$ILS_20)
summary(allItem_ILS_Dataset$ILS_20)


plot(sort(allItem_ILS_Dataset$ILS_20))

merged_ILS = merge(allItem_ILS_Dataset, allItem_ILS_BPRMF, by.x="User", by.y="User", )
colnames(merged_ILS) = c("User", "Profile_ILS", "BPFMF_ILS")
merged_ILS = merged_ILS[order(-merged_ILS$BPFMF_ILS),]

plot(sort(merged_ILS[,3]),col="red")

plot(sort(merged_ILS[,2]),col="blue")

par(new=TRUE)

summary(merged_ILS[,2])
boxplot(merged_ILS[,2], outline = F)
summary(merged_ILS[,3])
boxplot(merged_ILS[,3], outline = F )

boxplot(x = as.list(as.data.frame(merged_ILS[,c(2,3)])), outline = F , main="User Profile and BPRMF recommendation ILS (Tags)", ylab="ILS@20")

barplot(sort(allItem_ILS_Dataset$ILS_5, decreasing = T), horiz = T, )


ggplot(allItem_ILS_Dataset, aes(y=(ILS_5), x = factor(allItem_ILS_Dataset$User)) ) + geom_bar(stat='identity') + coord_flip()


barplot(sort(allItem_ILS_Dataset$ILS_5, decreasing = T), horiz = T, )


