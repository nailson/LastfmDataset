

colnames(coleta) = c("userName","artistName","artistMbid","artistUrl","playcount","rank")
coleta2 =  coleta[nchar(as.character(coleta$artistMbid))==36,]

coleta2 = merge(coleta2, users_dataset, by.x = "userName", by.y="V1")

mapping_LF_dbpedia_artists = mapping_LF_dbpedia_artists[mapping_LF_dbpedia_artists$V1%in%artists_category$V1,]


coleta2 = merge(coleta2, mapping_LF_dbpedia_artists, by.x = "artistMbid", by.y="V4")


dataset2 = coleta2[, c("V2.x", "V1", "playcount")]

colnames

colnames(dataset2) = c("id_user", "V1", "weight")
dataset = dataset2


dataset$id_user = as.numeric(dataset$id_user)
dataset$weight = as.numeric(dataset$weight)
dataset$V1 = as.numeric(dataset$V1)
