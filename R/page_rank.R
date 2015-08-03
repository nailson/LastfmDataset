
require(igraph)
require("sna")

genre_derivative <- read.delim("../new data/genre relation/genre_derivative_final.tsv", header=F)
genre_derivative.network<-graph.data.frame(genre_derivative, directed=T) #the 'directed' attribute specifies whether the edges are directed


x = page_rank(genre_derivative.network, algo = c("prpack", "arpack", "power"), vids = V(genre_derivative.network),
          directed = TRUE, damping = 0.85, personalized = NULL, weights = NULL,
          options = NULL)



adjacencyMatrix <- table(genre_derivative)

pageRank <- page.rank(genre_derivative.network)$vector
as.matrix(sort(pageRank))
plot(pageRank, evcent(genre_derivative.network, directed = TRUE)$vector)

pageRankColor <- hsv(0, 1, (pageRank - min(pageRank)) /
                       (max(pageRank) - min(pageRank)))
pageRankScaler <- pageRank * 100 + 0.6

par(mai=c(0,0,0,0)) 
prettyPlot <- gplot(dat = adjacencyMatrix,
                    label = NULL,
                    mode = "kamadakawai",
                    pad = 0,
                    label.pad = 1,
                    boxed.labels = TRUE,
                    label.pos = 1,  # Below vertex
                    label.bg = "#ffffff99",
                    vertex.sides = 100,  # Basically circular
                    arrowhead.cex = pageRankScaler,
                    label.cex = pageRankScaler,
                    vertex.cex = pageRankScaler,
                    edge.col = "#ffffff99",  # To make translucent bounding box
                    label.col = pageRankColor,
                    vertex.col = pageRankColor,
                    label.border = "#ffffff00",  # To hide borders
                    vertex.border = "#ffffff00")  # To hide borders


prettyPlot <- gplot(dat = adjacencyMatrix,
                    label = NULL,
                    mode = "springrepulse",
                    pad = 0,
                    label.pad = 0,
                    boxed.labels = TRUE,
                    label.pos = 0,  # Below vertex
                    label.bg = "#ffffff99",
                    vertex.sides = 1000,  # Basically circular
                    arrowhead.cex = pageRankScaler,
                    label.cex = 0,
                    vertex.cex = pageRankScaler,
                    edge.col = "#ffffff99",  # To make translucent bounding box
                    label.col = pageRankColor,
                    vertex.col = pageRankColor,
                    label.border = "#ffffff00",  # To hide borders
                    vertex.border = "#ffffff00")  # To hide borders