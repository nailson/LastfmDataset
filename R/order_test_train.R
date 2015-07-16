

for(i in c("0","1","2","3") ){
  path = paste("~/GitHub/Recommendations/data/test_", i, ".csv", sep="")
  test <- read.delim(path, , header=F)
  test <- test[order(test$V1, -test$V3, test$V2),]
  write.table(test,paste("test_", i, ".csv", sep=""), sep='\t', col.names=F, row.names=F, quote=F )
}

for(i in c("0","1","2","3") ){
  path = paste("~/GitHub/Recommendations/data/train_", i, ".csv", sep="")
  test <- read.delim(path, , header=F)
  test <- test[order(test$V1, -test$V3, test$V2),]
  write.table(test,paste("train_", i, ".csv", sep=""), sep='\t', col.names=F, row.names=F, quote=F )
}