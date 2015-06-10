

map_lf_dbpedia_artists <- read.table("map_lf_dbpedia_artists.tsv", header=TRUE, quote="\"")

lastfm = unique(map_lf_dbpedia_artists[,c(1,2,3,5,6)])

lastfm = lastfm[order(-lastfm$playcount),]

x =  lastfm[!duplicated(lastfm[,c("mbid","name","lf_url"),]),]

write.table(x, file="map_artists.tsv", sep="\t", col.names=F)


tottaly_map = merge(x, map_lf_dbpedia_artists, by.x=c("mbid", "name","lf_url"), by.y=c("mbid", "name","lf_url"))

tottaly_map = merge(x, map_lf_dbpedia_artists, by.x=c("mbid", "name","lf_url"), by.y=c("mbid", "name","lf_url"))

write.table(mapss, file="map_lf_id_db.tsv", sep="\t", col.names=F)




c_unic = unique(c[,c("X.artistName.","X.artistMbid.","X.artistUrl.")])



in_map = c_unic[c_unic$X.artistMbid.%in%x$mbid,]
not_in_map =  c_unic[!(c_unic$X.artistMbid.%in%x$mbid),]

in_map_name = not_in_map[tolower(not_in_map$X.artistName.)%in%tolower(x$name),]
in_map_name = in_map_name[in_map_name$X.artistName.!="",]
in_map_name = unique(in_map_name)
not_in_map = not_in_map[!(tolower(not_in_map$X.artistName.)%in%tolower(x$name)),]

in_map_url = not_in_map[tolower(not_in_map$X.artistUrl.)%in%tolower(x$lf_url),]
not_in_map = not_in_map[!(tolower(not_in_map$X.artistUrl.)%in%tolower(x$lf_url)),]

mapped = rbind(in_map, rbind(in_map_name, in_map_url) )
mapped = unique(mapped)

