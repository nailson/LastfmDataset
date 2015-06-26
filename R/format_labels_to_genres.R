
artist_id_genre = artist_id_genre[(grepl("http",artist_id_genre$V2)),]

z2 = text_genre[grepl("http",text_genre$V2) ,]

x$V2 = gsub(x$V2, "@en")

artist_id_genre2 =  artist_id_genre[!(grepl("@en",artist_id_genre$V2)),]
write.table(z, file="text_genre.tsv", col.names=F, row.names=F, quote=F, sep="\t")

new_x = data.frame(V1=c(), V2=c())

for(index in x$V1){
  aux = unlist(strsplit( x[x$V1==index,2],','))
  new_x = rbind( new_x, data.frame( V1=rep(index, length(aux) ), V2= aux) )
}


trim <- function( x ) {
  gsub("(^[[:space:]]+|[[:space:]]+$)", "", x)
}

y$V2 = trim(y$V2)

all.Musicgenres.from.dbpedia.with.name$V2 = tolower(all.Musicgenres.from.dbpedia.with.name$V2)
$V2 = tolower(text_genre$V2)

text_genre = merge(text_genre, all.Musicgenres.from.dbpedia.with.name, by.x="V2", by.x="V2")

all.Musicgenres.from.dbpedia.with.name = unique(all.Musicgenres.from.dbpedia.with.name)
text_genre = unique(text_genre)
typeof(all.Musicgenres.from.dbpedia.with.name$V2)


e = aggregate(z$text, by=list(z$text), FUN=length)
e = e[order(-e$x),]
