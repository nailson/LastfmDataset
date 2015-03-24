


u = cbind( u, novo = rep(1,length(u$V1)) )

colnames(u) = c("userID", "artistID","weight","one")

aggroup =  aggregate(u$userID, by =list(u$userID),FUN=length )

x = aggroup$Group.1[aggroup$x < 20]

novo_arquivo = u[!u$userID %in% x, ]

aggroupWeight =  aggregate(u$weight, by =list(u$userID),FUN=median )

newU = merge( u, aggroupWeight, by.x = "userID", by.y = "Group.1", all.x = TRUE )

write.table(u, file = "u.data", sep = "\t",  row.names = FALSE, col.names = FALSE)
