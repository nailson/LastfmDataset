library("ggplot2")

allItemTest = data.frame( fator="Test", ILD = allItem_ILS_Test$ILS_5 )

aggregate

error_bar <- function(x){
  data.frame(resp = mean(x), se = qt(0.975,df=length(x)-1)*sd(x)/sqrt(length(x)) )
}

df = error_bar(allItem_ILS_Test[,2])
df = rbind(df,error_bar(allItem_ILS_BPRMF[,2]))
df = rbind(df,error_bar(allItem_ILS_KNN[,2]))

df$trt = c("Test", "BPRMF", "KNN")
df$group = factor(c(1:length(df$trt)))


# Define the top and bottom of the errorbars
limits <- aes(ymax = resp + se, ymin=resp - se)

p <- ggplot(df, aes(colour=group, y=resp, x=trt))
p + geom_point() + geom_errorbar(limits, width=0.2)
