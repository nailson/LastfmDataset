
# READ FILE
new_genre <- read.delim("new_genre.tsv", header=F)
map_genre <- read.delim("../new data/map/map_genre.tsv", header=F)


# ITS @en GENRE?
en_genres = data.frame( V1 = new_genre[ grepl("http://dbpedia.org",new_genre$V1), ] )
length_id = length(map_genre$V1)+1
en_genres$V2 = c(length_id:(length_id+length(en_genres$V1) - 1))


# BIND @en genres
map_genre = rbind(map_genre, en_genres)
write.table(map_genre, file="map_genre.tsv", col.names=F, row.names=F, quote=F, sep="\t")


# ITS @pt genre?
all.Genres.from.dbpedia.with.pt.genre <- read.delim("C:/Users/Nailson/Dropbox/UFCG/Arquivos/all Genres from dbpedia with pt genre.txt", header=F, quote="")

new_genre = data.frame( V1 = new_genre[ !(new_genre$V1%in%map_genre$V1), ] )
x = all.Genres.from.dbpedia.with.pt.genre[tolower(all.Genres.from.dbpedia.with.pt.genre$V2)%in%tolower(new_genre$V1), ]
x$same = as.character(tolower(x$same))
colnames(x) = c("en","pt","same")

w = artist_genre
w$same = as.character(tolower(w$V2))
w = merge(w, x, by.x="same", by.y="same", all.x = T)
w[ is.na(w$en), c("en")] = as.character(w[ is.na(w$en), c("V2")])
w = w[, c("V1","en")]

write.table(w, file="artist_genre.tsv", col.names=F, row.names=F, quote=F, sep="\t")

# all Genres countrys

all.Genres.from.dbpedia.with.ko.pt.el.de.es.genre <- read.delim("C:/Users/Nailson/Dropbox/UFCG/Arquivos/all Genres from dbpedia with ko pt el de es genre.txt", header=F, quote="")
new_genre = data.frame( V1 = new_genre[ !(new_genre$V1%in%map_genre$V1), ] )
x = all.Genres.from.dbpedia.with.ko.pt.el.de.es.genre[tolower(all.Genres.from.dbpedia.with.ko.pt.el.de.es.genre$V2)%in%tolower(new_genre$V1), ]
x$same = as.character(tolower(x$V1))
colnames(x) = c("en","pt","same")

w = artist_genre
w$same = as.character(tolower(w$V2))
w = merge(w, x, by.x="same", by.y="same", all.x = T)
w$en = as.character(w$en)
w[ is.na(w$en), c("en")] = as.character(w[ is.na(w$en), c("V2")])
w = w[, c("V1","en")]
write.table(w, file="artist_genre.tsv", col.names=F, row.names=F, quote=F, sep="\t")

# SAME URL
url = data.frame( url = map_genre$V1, same = tolower(substring( map_genre$V1, 29)) )
new_genre$same = tolower(substring(new_genre$V1, 32 ))

x = merge(new_genre, url, by="same")
x = x[,c("V1","url")]
colnames(x) = c("V2","url")

w = artist_genre
w = merge(w, x, by.x="V2", all.x=T)
w$url = as.character(w$url)
w[ is.na(w$url), c("url")] = as.character(w[ is.na(w$url), c("V2")])
w = w[, c("V1","url")]
w = w[order(w$V1),]
w = w[,c(2,1)]
write.table(w, file="artist_genre.tsv", col.names=F, row.names=F, quote=F, sep="\t")
