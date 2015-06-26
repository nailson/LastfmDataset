library("ggplot2")
library("asbio")

error_bar <- function(x){
  data.frame(resp = mean(x), se = qt(0.975,df=length(x)-1)*sd(x)/sqrt(length(x)) )
}

error_bar_median <- function(x){
  data.frame(resp = median(x), se = qt(0.975,df=length(x)-1)*mad(x, center = median(x))/sqrt(length(x))  )
}

allItem_ILS_Train <- read.delim("~/Documentos/Mestrado/Git/mestrado_UFCG/java workspace/DiversificationAlgorithms/data/allItem_ILS_Train 1.tsv")
allItem_ILS_Test <- read.delim("~/Documentos/Mestrado/Git/mestrado_UFCG/java workspace/DiversificationAlgorithms/data/allItem_ILS_Test 1.tsv")
allItem_ILS_BPRMF <- read.delim("~/Documentos/Mestrado/Git/mestrado_UFCG/java workspace/DiversificationAlgorithms/data/allItem_ILS_BPRMF 1.tsv")
allItem_ILS_KNN <- read.delim("~/Documentos/Mestrado/Git/mestrado_UFCG/java workspace/DiversificationAlgorithms/data/allItem_ILS_KNN 1.tsv")


df = error_bar_median(allItem_ILS_Test[,2])
df = rbind(df,error_bar_median(allItem_ILS_BPRMF[,2]))
df = rbind(df,error_bar_median(allItem_ILS_KNN[,2]))
df = rbind(df,error_bar_median(allItem_ILS_Train[,2]))

df$trt = c("Test", "BPRMF", "KNN", "Train")
df$group = factor(df$trt)


# Define the top and bottom of the errorbars
limits <- aes(ymax = resp + se, ymin=resp - se)

p <- ggplot(df, aes(colour=group, y=resp, x=trt))
p + geom_errorbar(limits, width=0.2, size=1.1) + geom_point(size=3, shape=21, fill="white")  + 
    labs(list(title = "Users ILD Error Bars ", x = "", y = "ILD@10") )



# Test its equals than BPRMF?
t.test(allItem_ILS_Test[,2],allItem_ILS_BPRMF[,2], paired = T)
# Test its greater than BPRMF?
t.test(allItem_ILS_Test[,2], allItem_ILS_BPRMF[,2], paired = T, alternative = "greater")
# Test its les than BPRMF?
t.test(allItem_ILS_Test[,2], allItem_ILS_BPRMF[,2], paired = T, alternative = "less")

# Test its equals than KNN?
t.test(allItem_ILS_Test[,2],allItem_ILS_KNN[,2], paired = T)
# Test its greater than KNN?
t.test(allItem_ILS_Test[,2], allItem_ILS_KNN[,2], paired = T, alternative = "greater")
# Test its les than KNN?
t.test(allItem_ILS_Test[,2], allItem_ILS_KNN[,2], paired = T, alternative = "less")

# Test its equals than Train?
t.test(allItem_ILS_Test[,2],allItem_ILS_Train[,2], paired = T)
# Test its greater than Train?
t.test(allItem_ILS_Test[,2], allItem_ILS_Train[,2], paired = T, alternative = "greater")
# Test its les than Train?
t.test(allItem_ILS_Test[,2], allItem_ILS_Train[,2], paired = T, alternative = "less")

# Train its equals than BPRMF?
t.test(allItem_ILS_Train[,2],allItem_ILS_BPRMF[,2], paired = T)
# Train its greater than BPRMF?
t.test(allItem_ILS_Train[,2], allItem_ILS_BPRMF[,2], paired = T, alternative = "greater")
# Train its les than BPRMF?
t.test(allItem_ILS_Train[,2], allItem_ILS_BPRMF[,2], paired = T, alternative = "less")

