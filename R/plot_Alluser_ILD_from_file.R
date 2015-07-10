
for (i in c("0","1","2","3") ){
  #print(i)
#}
  i= "3"
  
  outputfile = paste("ILD_base_",i,".png")
  
  allItem_ILS_BPRMF50.0.10 <- read.delim(paste("~/GitHub/mestrado_UFCG/java workspace/DiversificationAlgorithms/data/allItem_ILS_BPRMF50-0.1",i,".txt",sep=""))
  allItem_ILS_BPRMF70.0.10 <- read.delim(paste("~/GitHub/mestrado_UFCG/java workspace/DiversificationAlgorithms/data/allItem_ILS_BPRMF70-0.10.txt",sep=""))
  
  allItem_ILS_BPRMF =data.frame(User= allItem_ILS_BPRMF50.0.10[,c(1)],  ILS_20 = ((allItem_ILS_BPRMF50.0.10[,c(2)]+allItem_ILS_BPRMF70.0.10[,c(2)])/2))
  allItem_ILS_BPRMF = allItem_ILS_BPRMF[order(allItem_ILS_BPRMF$User),]
  
  
  allItem_ILS_UserKNN0_20 <- read.delim(paste("~/GitHub/mestrado_UFCG/java workspace/DiversificationAlgorithms/data/allItem_ILS_UserKNN",i,"_20.txt",sep=""))
  allItem_ILS_UserKNN0_30 <- read.delim(paste("~/GitHub/mestrado_UFCG/java workspace/DiversificationAlgorithms/data/allItem_ILS_UserKNN",i,"_30.txt",sep=""))
  
  allItem_ILS_KNN = data.frame(User= allItem_ILS_UserKNN0_20[,c(1)],  ILS_20 = ((allItem_ILS_UserKNN0_20[,c(2)]+allItem_ILS_UserKNN0_30[,c(2)])/2))
  allItem_ILS_KNN = allItem_ILS_KNN[order(allItem_ILS_KNN$User),]
  
  allItem_ILS_Test <- read.delim(paste("~/GitHub/mestrado_UFCG/java workspace/DiversificationAlgorithms/data/allItem_ILS_test_",i,".csv",sep=""))
  allItem_ILS_Train <- read.delim(paste("~/GitHub/mestrado_UFCG/java workspace/DiversificationAlgorithms/data/allItem_ILS_train_",i,".csv",sep=""))
  
  source("plot_errorBar_UserILD.R")
  
#system(paste("plot_errorBar_UserILD.R",outputfile))
}
