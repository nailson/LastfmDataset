

dataset <- read.delim("~/GitHub/LastfmDataset/R/dataset.tsv", header=F)

artist_id_genre <- read.delim("~/GitHub/LastfmDataset/R/artist_id_genre.tsv", header=F)

x = data.frame( V1 = unique(dataset[!(dataset$V2%in%artist_id_genre$V1),2]))

map_lf_id_db <- read.delim("~/GitHub/LastfmDataset/R/map_lf_id_db.tsv", header=F, quote="")

x = merge(x,map_lf_id_db, by="V1")

write.table(x, file="not_have_genre.tsv", col.names=F, row.names=F, sep="\t", quote=F )
