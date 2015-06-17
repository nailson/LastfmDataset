allItem_ILS_Dataset = allItem_ILS_Test
boxplot(allItem_ILS_Dataset$ILS_5)
summary(allItem_ILS_Dataset$ILS_5)


plot(sort(allItem_ILS_Dataset$ILS_5))

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


ggplot(allItem_ILS_Dataset, aes(y=(ILS_5), x = factor(allItem_ILS_Dataset$User)) ) + geom_bar(stat='identity') + coord_flip()


qplot(x=c(1:8049), y=allItem_ILS_Dataset$ILS_5, 
      data=means, geom="bar", stat="identity",
      position="dodge")


myci <- function(t) {
  n <- length(t) # n is the sample size
  se <- sd(t)/sqrt(n); # Find the standard error of the sample
  m <- mean(t); # Find the sample mean
  cv <- qt(0.975,df=n-1) # cv is a critical value for the t distribution. P( t > cv ) = 0.025 = P( t < -cv )
  c(m-cv*se,m+cv*se) # Return the 95% confidence interval
}


x = myci(merged_ILS[,2])
x = myci(merged_ILS[,3])




t.test(merged_ILS[,3], merged_ILS[,2], paired = T)

t.test(merged_ILS[,3], merged_ILS[,2], paired = T, alternative = "greater")

t.test(merged_ILS[,3], merged_ILS[,2], paired = T, alternative = "less")



error <- qt(0.975,df=length(merged_ILS[,2])-1)*sd(merged_ILS[,2])/sqrt(length(merged_ILS[,2]))
left <- mean(merged_ILS[,2])-error
right <- mean(merged_ILS[,2])+error

error <- qt(0.975,df=length(merged_ILS[,3])-1)*sd(merged_ILS[,3])/sqrt(length(merged_ILS[,3]))
left <- mean(merged_ILS[,3])-error
right <- mean(merged_ILS[,3])+error

median(merged_ILS[,2])
