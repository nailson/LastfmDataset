

Subject2 <- read.delim("~/GitHub/mestrado_UFCG/java workspace/LODCrawler/data/Subject2.txt", header=F)
map_subjet <- read.delim("~/GitHub/LastfmDataset/new data/map/map_subjet.tsv", header=F)

Subject2 = Subject2[,c(2,1)]
colnames(Subject2) = c("V1","V2")


x = Subject2[Subject2$V1%in%map_subjet$V1,]

colnames(x) = c("url_subj","url_pred")

x = merge(x, map_subjet, by.y="V1",by.x="url_subj")

x = x[,c(3,2)]

y = x[!(x$url_pred%in%map_subjet$V1),]

y = data.frame(V1 = unique(y$url_pred))
length_id = length(map_subjet$V2)+1
last_id = length_id+length(y$V1)
y$V2 =  c(length_id:(last_id - 1))
map_subjet = rbind(map_subjet, y)
write.table(map_subjet, file="map_subjet.tsv", col.names=F, row.names=F, quote=F, sep="\t")

colnames(map_subjet) = c("url_1","url_2")
x = merge(x, map_subjet, by.y="url_1",by.x="url_pred")
x = x[,c(2,3)]
x = x[order(x$V2,x$url_2),]

write.table(x, file="subject_broader.tsv", col.names=F, row.names=F, quote=F, sep="\t")

