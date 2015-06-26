
# READ FILES
artist_subject <- read.delim("../new data/artist relation/artist_subject.tsv", header=F)
dataset <- read.delim("../new data/dataset.tsv", header=F)
map_dbpedia <- read.delim("~/GitHub/LastfmDataset/new data/map/map_dbpedia.tsv", header=F)
all_Artists_subject <- read.delim("C:/Users/Nailson/Dropbox/UFCG/Arquivos/all Artists from dbpedia with subject", header=F, quote="")
                          
# FIND ARTISTS THAT NOT HAVE TAGS
x = data.frame( V1 = unique(dataset[ !(dataset$V2%in%artist_subject$V1),2]) )

# MERGE WITH MAP ARTISTS
x = merge(x,map_dbpedia, by="V1")

# MERGE WITH MAP ALL SUBJECTS
colnames(all_Artists_subject) = c("url","subj")
z = merge(x, all_Artists_subject, by.x="V2", by.y="url")
z = z[,c(2,3)]
colnames(z) = c("V1","V2")

artist_subject = rbind(artist_subject, z)
artist_subject = unique(artist_subject)
write.table(artist_subject, file="artist_subject.tsv", col.names=F, row.names=F, quote=F, sep="\n")
