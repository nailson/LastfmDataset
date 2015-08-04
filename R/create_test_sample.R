

dataset_norm <- read.delim("~/GitHub/LastfmDataset/new data/dataset_norm.tsv", header=F)
UserKNN0_30 <- read.delim("~/GitHub/Recommendations/KNN/UserKNN0_30.txt", header=F)
test_0 <- read.delim("~/GitHub/Recommendations/data/test_0.csv", header=F)
train_0 <- read.delim("~/GitHub/Recommendations/data/train_0.csv", header=F)


user_test = unique(dataset_norm$V1)

users = user_test[sample(length(user_test), 50)]

dataset_test = dataset_norm[ dataset_norm$V1%in%users, ]


write.table(dataset_test, file = "dataset_test.tsv", sep='\t', col.names=F, row.names=F, quote=F )

UserKNN0_30_test = UserKNN0_30[ UserKNN0_30$V1%in%users, ]
test_0 = test_0[ test_0$V1%in%users , ]
train_0 = train_0[ train_0$V1%in%users , ]

write.table(UserKNN0_30_test, file = "UserKNN0_30_test.tsv", sep='\t', col.names=F, row.names=F, quote=F )
write.table(test_0, file = "test_0_test.tsv", sep='\t', col.names=F, row.names=F, quote=F )
write.table(train_0, file = "train_0_test.tsv", sep='\t', col.names=F, row.names=F, quote=F )


