#install.packages('gridExtra')
library('ggplot2')
library('gridExtra')

results <- read.delim("../../mestrado_UFCG/java workspace/DiversificationAlgorithms/data/results0.tsv", header=FALSE)

colnames(results) = c("base", "model","metric","value")

resultaggrdiv = subset(results, results$metric == "aggrdiv")
resulteild = subset(results, results$metric == "eild")
resultprec = subset(results, results$metric == "prec")
resultandcg = subset(results, results$metric == "a-ndcg")
resultgini = subset(results, results$metric == "gini")
resultILS = subset(results, results$metric == "ild")
resultSRecall = subset(results, results$metric == "srecall")
resultndcg = subset(results, results$metric == "ndcg")
resultFmeasure = subset(results, results$metric == "F-measure")


Modelo = as.factor(resultILS$model)

ggplot(resultILS, aes(x = as.factor(resultILS$model), y = resultILS$value, fill=Modelo))+ 
  #geom_bar(stat = "identity")+
  stat_summary(fun.y=mean, geom="bar", position="dodge", colour='white',show_guide = FALSE)+
  #scale_y_continuous(breaks=seq(0, 1,0.01))+
  coord_cartesian(ylim=c(0.35,0.48))+
  labs(list(x="", y="ILD@5", col=""))+ scale_fill_hue()

ModeloSRecall = as.factor(resultSRecall$model)

ggplot(resultSRecall, aes(x = as.factor(resultSRecall$model), y = resultSRecall$value, fill=ModeloSRecall))+ 
  #geom_bar(stat = "identity")+
  stat_summary(fun.y=mean, geom="bar", position="dodge", colour='white',show_guide = FALSE)+
  #scale_y_continuous(breaks=seq(0, 1,0.01))+
  coord_cartesian(ylim=c(0.002,0.0033))+
  labs(list(x="", y="SRecall", col=""))+ scale_fill_hue()


Modeloeild = as.factor(resulteild$model)

ggplot(resulteild, aes(x = as.factor(resulteild$model), y = resulteild$value, fill=Modeloeild))+ 
  #geom_bar(stat = "identity")+
  stat_summary(fun.y=mean, geom="bar", position="dodge", colour='white',show_guide = FALSE)+
  #scale_y_continuous(breaks=seq(0, 1,0.01))+
  coord_cartesian(ylim=c(0.1,0.16))+
  labs(list(x="", y="EILD", col=""))+ scale_fill_hue()

Modeloandcg = as.factor(resultandcg$model)

ggplot(resultandcg, aes(x = as.factor(resultandcg$model), y = resultandcg$value, fill=Modeloandcg))+ 
  #geom_bar(stat = "identity")+
  stat_summary(fun.y=mean, geom="bar", position="dodge", colour='white',show_guide = FALSE)+
  #scale_y_continuous(breaks=seq(0, 1,0.01))+
  coord_cartesian(ylim=c(0.07,0.12))+
  labs(list(x="", y="A-NDCG", col=""))+ scale_fill_hue()


Modeloprec = as.factor(resultprec$model)

ggplot(resultprec, aes(x = as.factor(resultprec$model), y = resultprec$value, fill=Modeloprec))+ 
  #geom_bar(stat = "identity")+
  stat_summary(fun.y=mean, geom="bar", position="dodge", colour='white',show_guide = FALSE)+
  #scale_y_continuous(breaks=seq(0, 1,0.01))+
  coord_cartesian(ylim=c(0.12,0.17))+
  labs(list(x="", y="Precision", col=""))+ scale_fill_hue()


Modelondcg = as.factor(resultndcg$model)

ggplot(resultndcg, aes(x = as.factor(resultndcg$model), y = resultndcg$value, fill=Modelondcg))+ 
  #geom_bar(stat = "identity")+
  stat_summary(fun.y=mean, geom="bar", position="dodge", colour='white',show_guide = FALSE)+
  #scale_y_continuous(breaks=seq(0, 1,0.01))+
  coord_cartesian(ylim=c(0.12,0.18))+
  labs(list(x="", y="NDCG", col=""))+ scale_fill_hue()


Modelofmeasure = as.factor(resultFmeasure$model)

ggplot(resultFmeasure, aes(x = as.factor(resultFmeasure$model), y = resultFmeasure$value, fill=Modelofmeasure))+ 
  #geom_bar(stat = "identity")+
  stat_summary(fun.y=mean, geom="bar", position="dodge", colour='white',show_guide = FALSE)+
  #scale_y_continuous(breaks=seq(0, 1,0.01))+
  coord_cartesian(ylim=c(0.09,0.12))+
  labs(list(x="", y="NDCG", col=""))+ scale_fill_hue()

