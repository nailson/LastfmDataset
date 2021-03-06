
artist_tags <- read.delim("../new data/artist relation/artist_tags_final.tsv", header=F, quote="")

summary(artist_tags$V3)
boxplot(artist_tags$V3)

length(unique(artist_tags$V1))

artist_tags = artist_tags[artist_tags$V3>0,]
artist_tags = artist_tags[order(artist_tags$V1, -artist_tags$V3, artist_tags$V2),]

new_artist_tags = data.frame(V1=c(), V2=c(), V3= c())

for(artist in unique(artist_tags$V1)){
  one_artist_tags <- artist_tags[ artist_tags$V1==artist, ]
  if(length(one_artist_tags$V2) > 10 ){
    one_artist_tags = one_artist_tags[c(1:10),]
  }
  new_artist_tags = rbind(new_artist_tags, one_artist_tags)
}

write.table(new_artist_tags, file="artist_tags.tsv", col.names=F, row.names=F, quote=F, sep="\t")
