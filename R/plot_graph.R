
require(igraph)


genre_derivative <- read.delim("../new data/genre relation/genre_derivative_final.tsv", header=F)
genre_derivative.network<-graph.data.frame(genre_derivative, directed=T) #the 'directed' attribute specifies whether the edges are directed

V(genre_derivative.network) #prints the list of vertices (people)
E(genre_derivative.network) #prints the list of edges (relationships)

degree(genre_derivative.network) #print the number of edges per vertex (relationships per people)
diameter(genre_derivative.network, directed = TRUE, unconnected = TRUE, weights = NULL)
get_diameter(genre_derivative.network)

# First try. We can plot the graph right away but the results will usually be unsatisfactory:
plot(genre_derivative.network)


#Subset the data. If we want to exclude people who are in the network only tangentially (participate in one or two relationships only)
# we can exclude the by subsetting the graph on the basis of the 'degree':

bad.vs<-V(bsk.network)[degree(bsk.network)<3] #identify those vertices part of less than three edges
bsk.network<-delete.vertices(bsk.network, bad.vs) #exclude them from the graph

# Plot the data.Some details about the graph can be specified in advance.
# For example we can separate some vertices (people) by color:

V(bsk.network)$color<-ifelse(V(bsk.network)$name=='CA', 'blue', 'red') #useful for highlighting certain people. Works by matching the name attribute of the vertex to the one specified in the 'ifelse' expression

# We can also color the connecting edges differently depending on the 'grade': 

E(bsk.network)$color<-ifelse(E(bsk.network)$grade==1, "red", "grey")

# or depending on the different specialization ('spec'):

E(bsk.network)$color<-ifelse(E(bsk.network)$spec=='stylisticOrigin', "red", ifelse(E(bsk.network)$spec=='Y', "blue", "grey"))

# Note: the example uses nested ifelse expressions which is in general a bad idea but does the job in this case
# Additional attributes like size can be further specified in an analogous manner, either in advance or when the plot function is called:

V(bsk.network)$size<-degree(bsk.network)/10#here the size of the vertices is specified by the degree of the vertex, so that people supervising more have get proportionally bigger dots. Getting the right scale gets some playing around with the parameters of the scale function (from the 'base' package)

# Note that if the same attribute is specified beforehand and inside the function, the former will be overridden.
# And finally the plot itself:
#par(mai=c(0,0,1,0))   		#this specifies the size of the margins. the default settings leave too much free space on all sides (if no axes are printed)

#png(filename="org_network.png", height=1800, width=1600) #call the png writer

plot(bsk.network,				#the graph to be plotted
     layout=layout.fruchterman.reingold,	# the layout method. see the igraph documentation for details
     main='Organizational network example',	#specifies the title
     vertex.label.dist=0.5,			#puts the name labels slightly off the dots
     vertex.frame.color='blue', 		#the color of the border of the dots 
     vertex.label.color='black',		#the color of the name labels
     vertex.label.font=5,			#the font of the name labels
     vertex.label=V(bsk.network)$name,		#specifies the lables of the vertices. in this case the 'name' attribute is used
     vertex.label.cex=0.7			#specifies the size of the font of the labels. can also be made to vary
)


#run the plot
dev.off() #dont forget to close the device
#And that's the end for now.