
# READ FILES
artist_subject <- read.delim("../new data/artist relation/artist_subject.tsv", header=F)
dataset <- read.delim("../new data/dataset.tsv", header=F)
map_dbpedia <- read.delim("../new data/map/map_dbpedia.tsv", header=F)
all_Artists_subject <- read.delim("C:/Users/Nailson/Dropbox/UFCG/Arquivos/all Artists from dbpedia with subject", header=F, quote="")
                          
# FIND ARTISTS THAT NOT HAVE TAGS
x = data.frame( V1 = unique(dataset[ !(dataset$V2%in%artist_subject$V1),2]) )

# MERGE WITH MAP ARTISTS
x = merge(x,map_dbpedia, by="V1")
x = unique(x)
x = x[order(x$V1),]
#write.table(x, file="not_have_subject.tsv", col.names=F, row.names=F, quote=F, sep="\t")


# MERGE WITH MAP ALL SUBJECTS
colnames(all_Artists_subject) = c("url","subj")
z = merge(x, all_Artists_subject, by.x="V2", by.y="url")
z = z[,c(2,3)]
colnames(z) = c("V1","V2")

artist_subject = rbind(artist_subject, z)
artist_subject = unique(artist_subject)
artist_subject$V1 = as.numeric(artist_subject$V1)
artist_subject = artist_subject[order(artist_subject$V1), ]
write.table(artist_subject, file="artist_subject.tsv", col.names=F, row.names=F, quote=F, sep="\t")


# CREATE MAP SUBJECT

map_subjet = data.frame( V1 =  unique(artist_subject$V2), V2 = c(1:length( unique(artist_subject$V2)) ) )
write.table(map_subjet, file="map_subjet.tsv", col.names=F, row.names=F, quote=F, sep="\t")

colnames(map_subjet) = c("V2","id")
artist_subject = merge(artist_subject, map_subjet, by="V2")

artist_subject_final = artist_subject[, c(2,3)]
artist_subject_final$V3 = rep(1, length(artist_subject_final$id))
artist_subject_final = artist_subject_final[order(artist_subject_final$V1, artist_subject_final$id),]

write.table(artist_subject_final, file="artist_subject_final.tsv", col.names=F, row.names=F, quote=F, sep="\t")
