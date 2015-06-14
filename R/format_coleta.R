
coleta <- read.delim("C:/Users/Nailson/Dropbox/coleta.txt", quote="")
map_artists <- read.delim("~/GitHub/LastfmDataset/new data/map_artists.tsv", header=F, quote="")

x = merge(coleta, map_artists, by.x=c("X.artistName.","X.artistMbid."), by.y=c("V3","V2"), all.x=F )


dataset = x[,c("X.userName.","V1", "X.playcount.","X.rank.")]
colnames(dataset) = c("user", "artist","playcount","rank")

map_user <- read.delim("~/GitHub/LastfmDataset/new data/map_user.tsv")

dataset2 = merge(dataset, map_user, by.x="user", by.y="name")
dataset2 = dataset2[, c("id", "artist", "playcount","rank")]

dataset2$id = as.integer(dataset2$id)
dataset2$rank = as.integer(dataset2$rank)
dataset2$playcount = as.integer(dataset2$playcount)
dataset2$artist = as.integer(dataset2$artist)

dataset2 = dataset2[ order(dataset2$user, -dataset2$playcount, dataset2$artist) ,]
