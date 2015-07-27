
# READ TABLES
map_artists <- read.delim("~/GitHub/LastfmDataset/new data/map/map_artists.tsv", header=F)

lodOutput <- read.delim("~/GitHub/mestrado_UFCG/java workspace/DiversificationAlgorithms/data/test data/lodOutput.tsp", header=F)
train_0_ <- read.delim("~/GitHub/mestrado_UFCG/java workspace/DiversificationAlgorithms/data/test data/train_0_.tsv", header=F)
test_0_117 <- read.delim("~/GitHub/mestrado_UFCG/java workspace/DiversificationAlgorithms/data/test data/test_0_117.tsv", header=F)

UserKNN0_30_117 <- read.delim("~/GitHub/mestrado_UFCG/java workspace/DiversificationAlgorithms/data/test data/UserKNN0_30_117.tsv", header=F)


test_0_117 = merge(test_0_117, map_artists, by.x="V2", by.y="V1")
test_0_117 = test_0_117[ ,c("V1","V3.y", "V3.x")]
write.table(test_0_117$V3.y, "use_case_test.tsv", col.names=F, row.names=F, quote=F, sep='\t')


UserKNN0_30_117 = merge(UserKNN0_30_117, map_artists, by.x="V2", by.y="V1")
UserKNN0_30_117 = UserKNN0_30_117[ ,c("V1","V3.y", "V3.x")]
UserKNN0_30_117 = UserKNN0_30_117[order(-UserKNN0_30_117$V3.x),]
write.table(UserKNN0_30_117$V3.y, "use_case_knn.tsv", col.names=F, row.names=F, quote=F, sep='\t')

lodOutput = merge(lodOutput, map_artists, by.x="V2", by.y="V1")
lodOutput = lodOutput[ ,c("V1","V3.y", "V3.x")]
lodOutput = lodOutput[order(-lodOutput$V3.x),]
write.table(lodOutput$V3.y, "use_case_lod.tsv", col.names=F, row.names=F, quote=F, sep='\t')


train_0_ = train_0_[train_0_$V1=='117',]
train_0_ = merge(train_0_, map_artists, by.x="V2", by.y="V1")
train_0_ = train_0_[ ,c("V1","V3.y", "V3.x")]
write.table(train_0_$V3.y, "use_case_train.tsv", col.names=F, row.names=F, quote=F, sep='\t')
