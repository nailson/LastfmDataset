
require(igraph)


genre_derivative <- read.delim("../new data/genre relation/genre_derivative_final.tsv", header=F)
map_genre <- read.delim("../new data/map/map_genre.tsv", header=F)

#url_genre_derivative = merge(map_genre, genre_derivative, by.x="V2", by.y="V1")[,c(2,3)]
#url_genre_derivative = merge(map_genre, url_genre_derivative, by.x="V2", by.y="V2")[,c(2,3)]
#colnames(url_genre_derivative) = c("genre","derivative")

#url_genre_derivative$genre = gsub("http://dbpedia.org/resource/","", as.character(url_genre_derivative$genre))
#url_genre_derivative$derivative = gsub("http://dbpedia.org/resource/","", as.character(url_genre_derivative$derivative))


genre_derivative.network<-graph.data.frame(genre_derivative, directed=T) #the 'directed' attribute specifies whether the edges are directed
genre_derivative.network



V(genre_derivative.network) #prints the list of vertices (people)
E(genre_derivative.network) #prints the list of edges (relationships)

degree(genre_derivative.network) #print the number of edges per vertex (relationships per people)

diameter(genre_derivative.network, directed = TRUE, unconnected = TRUE, weights = NULL)
get_diameter(genre_derivative.network)
edge_connectivity(genre_derivative.network)
edge_density(genre_derivative.network, loops = FALSE) #The density of a graph is the ratio of the number of edges and the number of possible edges.
degree.distribution(genre_derivative.network)
x = embed_adjacency_matrix(genre_derivative.network,1)

pageRank <- page.rank(genre_derivative.network)$vector
# First try. We can plot the graph right away but the results will usually be unsatisfactory:
plot(genre_derivative.network,vertex.label=NA,edge.arrow.size=0.1,vertex.size=pageRank*300, layout=layout.graphopt,layout=layout.bipartite )
plot( genre_derivative.network, vertex.size=1, vertex.label=NA, edge.arrow.size=0, vertex.shape="none")

#Subset the data. If we want to exclude people who are in the network only tangentially (participate in one or two relationships only)
# we can exclude the by subsetting the graph on the basis of the 'degree':

bad.vs<-V(genre_derivative.network)[degree(genre_derivative.network)<3] #identify those vertices part of less than three edges
genre_derivative.network<-delete.vertices(genre_derivative.network, bad.vs) #exclude them from the graph

# Plot the data.Some details about the graph can be specified in advance.
# For example we can separate some vertices (people) by color:

V(genre_derivative.network)$color<-ifelse(V(genre_derivative.network)$name=='CA', 'blue', 'red') #useful for highlighting certain people. Works by matching the name attribute of the vertex to the one specified in the 'ifelse' expression

# We can also color the connecting edges differently depending on the 'grade': 

E(genre_derivative.network)$color<-ifelse(E(genre_derivative.network)$grade==1, "red", "grey")

# or depending on the different specialization ('spec'):

E(genre_derivative.network)$color<-ifelse(E(genre_derivative.network)$spec=='stylisticOrigin', "red", ifelse(E(genre_derivative.network)$spec=='Y', "blue", "grey"))

# Note: the example uses nested ifelse expressions which is in general a bad idea but does the job in this case
# Additional attributes like size can be further specified in an analogous manner, either in advance or when the plot function is called:

V(genre_derivative.network)$size<-degree(genre_derivative.network)/10#here the size of the vertices is specified by the degree of the vertex, so that people supervising more have get proportionally bigger dots. Getting the right scale gets some playing around with the parameters of the scale function (from the 'base' package)

# Note that if the same attribute is specified beforehand and inside the function, the former will be overridden.
# And finally the plot itself:
par(mai=c(0,0,0,0))   		#this specifies the size of the margins. the default settings leave too much free space on all sides (if no axes are printed)

#png(filename="org_network.png", height=1800, width=1600) #call the png writer

plot(genre_derivative.network,				#the graph to be plotted
     layout=layout.fruchterman.reingold,	# the layout method. see the igraph documentation for details
     main='Organizational network example',	#specifies the title
     vertex.label.dist=0.5,			#puts the name labels slightly off the dots
     vertex.frame.color='blue', 		#the color of the border of the dots 
     vertex.label.color='black',		#the color of the name labels
     vertex.label.font=5,			#the font of the name labels
     vertex.label=V(genre_derivative.network)$name,		#specifies the lables of the vertices. in this case the 'name' attribute is used
     vertex.label.cex=0.7			#specifies the size of the font of the labels. can also be made to vary
)


#run the plot
dev.off() #dont forget to close the device
#And that's the end for now.
