
coleta2 = coleta2[ nchar(as.character(coleta2$artistMbid))==36,]


coleta2 = merge(coleta, users_dataset, by.x="userName", by.y="V1")

coleta2 = merge(coleta, mapping_LF_dbpedia_artists, by.x="artistMbid", by.y="V4")


dataset = coleta2[, c("", "")]