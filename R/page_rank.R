
require(igraph)


genre_derivative <- read.delim("../new data/genre relation/genre_derivative_final.tsv", header=F)
genre_derivative.network<-graph.data.frame(genre_derivative, directed=T) #the 'directed' attribute specifies whether the edges are directed


x = page_rank(genre_derivative.network, algo = c("prpack", "arpack", "power"), vids = V(genre_derivative.network),
          directed = TRUE, damping = 0.85, personalized = NULL, weights = NULL,
          options = NULL)

