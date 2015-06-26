# PART I

colnames(categories) = c("id","url")
colnames(genre_connection) = c("url1","url2")

derivative = unique(append (as.character(genre_connection$url1), as.character(genre_connection$url2))) 

newcat = ( derivative[!(derivative%in%as.character(categories$url))])
index = length(categories$id)+1

categories = rbind( categories, data.frame(  id = c(index:(index+length(newcat)-1))   ,  url=newcat) )

newderivate = merge(  categories , genre_connection, by.x="url", by.y="url1", )
newderivate = newderivate[,c(2,3)]
colnames(newderivate) = c("id_genre1","url_genre2")
newderivate = merge(  categories , newderivate, by.x="url", by.y="url_genre2", )
newderivate = newderivate[,c(3,2)]
colnames(newderivate) = c("id_genre1","id_genre2")
newderivate = newderivate[order(newderivate$id_genre1),]

write.table(newderivate, file="derivative.tsv", sep="\t", quote=F, row.names=F, col.names=F)

write.table(newderivate, file="instrument.tsv", sep="\t", quote=F, row.names=F, col.names=F)

write.table(newderivate, file="fusiongenre.tsv", sep="\t", quote=F, row.names=F, col.names=F)

write.table(newderivate, file="subgenre.tsv", sep="\t", quote=F, row.names=F, col.names=F)

write.table(newderivate, file="stylistic.tsv", sep="\t", quote=F, row.names=F, col.names=F)


# PART II

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


