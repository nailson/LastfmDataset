
artists_musicbrainz <- read.delim("../data/artists_musicbrainz_dbpedia_link.txt", header=F, dec=",", quote="")
dataset_artists <- read.delim("../data/dataset_artists.tsv", header=F)
dataset_artists$V3 = as.character(dataset_artists$V3)
artists_musicbrainz$mbid =  substr(x = artists_musicbrainz$V1, start = 32, stop = 67)

merged_dbpedia = merge(x = dataset_artists, y = artists_musicbrainz, by.x = "V3", By.y="mbid")

linkedbase = merge(x = dataset_artists, y = artists_musicbrainz, by.x = "V3", by.y="mbid", all.x=F)

linkedbase = linkedbase[,c(2,3,1,4,5,7)]
colnames(linkedbase) = c("id", "name", "mbid", "url_lastfm", "url_mb", "url_dbpedia")
linkedbase = linkedbase[order(linkedbase$id),]
linkedbase2= linkedbase[ !duplicated(linkedbase$id), ]

linkedbase2$url_dbpedia = gsub('<','',linkedbase2$url_dbpedia)
linkedbase2$url_dbpedia = gsub('>','',linkedbase2$url_dbpedia)


x = new_merge [ !new_merge$V3%in%linkedbase2$mbid,]
x= x[c("V1", "name", "V3", "url", "V2.x" )]
colnames(x) = c("id","name","mbid","url_lastfm","url_dbpedia")
x$url_mb = paste("<http://musicbrainz.org/artist/", x$mbid,"#_>", sep="") 
lastLinked = rbind(linkedbase2, x)

write.table(lastLinked, file="mapping_LF_dbpedia_artists.tsv", sep="\t", quote=F, row.names=F, col.names=F)

write.table(artists_url, file="artists_url.tsv", sep="\t", quote=F, row.names=F, col.names=F)
