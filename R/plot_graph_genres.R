require(igraph)

genre_derivative <- read.delim("../new data/genre relation/genre_derivative_final.tsv", header=F)
genre_musicFusionGenre_final <- read.delim("~/GitHub/LastfmDataset/new data/genre relation/genre_musicFusionGenre_final.tsv", header=F)
genre_musicSubgenre_final <- read.delim("~/GitHub/LastfmDataset/new data/genre relation/genre_musicSubgenre_final.tsv", header=F)
genre_stylisticOrigin_final <- read.delim("~/GitHub/LastfmDataset/new data/genre relation/genre_stylisticOrigin_final.tsv", header=F)

genre = cbind(genre_derivative, type = rep("derivative",length(genre_derivative$V1)))
genre = rbind(genre, cbind(genre_musicFusionGenre_final, type = rep("musicFusionGenre",length(genre_musicFusionGenre_final$V1))))
genre = rbind(genre, cbind(genre_musicSubgenre_final, type = rep("musicSubgenre",length(genre_musicSubgenre_final$V1))))
#genre = rbind(genre, cbind(genre_stylisticOrigin_final, type = rep("stylisticOrigin",length(genre_stylisticOrigin_final$V1))))


genre.network<-graph.data.frame(genre, directed=T) #the 'directed' attribute specifies whether the edges are directed
genre_cluster = clusters(genre.network, mode=c("weak", "strong"))

E(genre.network)$color<-ifelse(E(genre.network)$type=='derivative', "red", ifelse(E(genre.network)$type=='musicFusionGenre', "blue", ifelse(E(genre.network)$type=='musicSubgenre', "grey", ifelse(E(genre.network)$type=='musicSubgenre',"brown", ifelse(E(genre.network)$type=='stylisticOrigin', "purple", "black"   )) )))

V(genre.network)$cluster = genre_cluster$membership
genre.network_copy <- delete.vertices(genre.network, which(V(genre.network)$cluster != 1))
summary(genre.network_copy)


pageRank <- page.rank(genre.network_copy)$vector

plot(genre.network_copy,vertex.frame.color='blue',vertex.label=NA,edge.arrow.size=0.05,vertex.size=pageRank*400, layout=layout.davidson.harel)



