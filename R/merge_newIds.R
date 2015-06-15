
#tag
mapping_newID <- read.delim("~/GitHub/LastfmDataset/R/mapping_newID.tsv", header=F, quote="")
colnames(mapping_newID) = c("V1", "new_id")

new_tags = merge(tags, mapping_newID, by.x="V1",by.y="V1")

write.table(new_tags[, c("new_id","V2","V3")], file="artist_tags.tsv", col.names=F, row.names=F, quote=F, sep="\t")

# subject
artists_subject <- read.delim("~/GitHub/LastfmDataset/data/artists relation/artists_subject.tsv", header=F, quote="")

new_artists_subject = merge(artists_subject, mapping_newID, by.x="V1",by.y="V1")

write.table(new_artists_subject[, c("new_id","V2")], file="artist_subject.tsv", col.names=F, row.names=F, quote=F, sep="\t")

#genre

artists_genre <- read.delim("~/GitHub/LastfmDataset/data/artists relation/artists_genre.tsv", header=F, quote="")

new_artists_genre = merge(artists_genre, mapping_newID, by.x="V1",by.y="V1")

write.table(new_artists_genre[, c("new_id","V2")], file="new_artists_genre.tsv", col.names=F, row.names=F, quote=F, sep="\t")


