require(igraph)

genre_derivative <- read.delim("../new data/genre relation/genre_derivative_final.tsv", header=F)
genre_derivative.network<-graph.data.frame(genre_derivative, directed=T) #the 'directed' attribute specifies whether the edges are directed

genre_cluster = clusters(genre_derivative.network, mode=c("weak", "strong"))
summary(genre_derivative.network)

V(genre_derivative.network)$cluster = genre_cluster$membership
V(genre_derivative.network)$color<-ifelse(V(genre_derivative.network)$cluster==1, 'blue', 'red') #useful for highlighting certain people. Works by matching the name attribute of the vertex to the one specified in the 'ifelse' expression


genre_derivative.network_copy <- delete.vertices(genre_derivative.network, which(V(genre_derivative.network)$cluster != 1))
summary(genre_derivative.network_copy)

par(mai=c(0,0,0,0))  
plot(genre_derivative.network_copy,vertex.label=NA,edge.arrow.size=0.1,vertex.size=pageRank*300, layout=layout.graphopt,layout=layout.auto)
layout=layout.fruchterman.reingold(genre_derivative.network_copy, niter=10000, area=30*vcount(genre_derivative.network_copy)^2)
plot.igraph(genre_derivative.network_copy,vertex.label=NA,edge.arrow.size=0.1,vertex.size=pageRank*500, layout=layout, vertex.shape="circle")

par(mai=c(1,1,1,1))  
barplot(sort(genre_cluster$csize, decreasing=T))
