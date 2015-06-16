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




ggplot(tgc2, aes(x=dose, y=len, fill=supp)) + 
  geom_bar(position=position_dodge(), stat="identity",
           colour="black", # Use black outlines,
           size=.3) +      # Thinner lines
  geom_errorbar(aes(ymin=len-se, ymax=len+se),
                size=.3,    # Thinner lines
                width=.2,
                position=position_dodge(.9)) +
  xlab("Dose (mg)") +
  ylab("Tooth length") +
  scale_fill_hue(name="Supplement type", # Legend label, use darker colors
                 breaks=c("OJ", "VC"),
                 labels=c("Orange juice", "Ascorbic acid")) +
  ggtitle("The Effect of Vitamin C on\nTooth Growth in Guinea Pigs") +
  scale_y_continuous(breaks=0:20*4) +
  theme_bw()


ggplot(resultILS, aes(x = as.factor(resultILS$model), y = resultILS$value, fill=Modelo))+ 
  #geom_bar(stat = "identity")+
  stat_summary(fun.y=mean, geom="bar", position="dodge", colour='white',show_guide = FALSE)+
  #scale_y_continuous(breaks=seq(0, 1,0.01))+
  coord_cartesian(ylim=c(0.30,0.42))+
  labs(list(x="", y="ILD@5", col=""))+ scale_fill_hue()


