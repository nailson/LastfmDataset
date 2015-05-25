
tags = tags[-1,]

colnames(tags) = c("mbid", "name","count", "url")

tags_name =  unique(tags$name)
tags_name = data.frame(id=c(1:length(tags_name)), name = tags_name)

write.table(tags_name, file="tags_id.tsv", col.names = T, row.names = F, sep="\t",)

new_tags = merge(tags_name, tags, by.x="name", by.y="name")
new_tags = merge(new_tags, mapping_lf_dbpedia_artists, by.x="mbid", by.y="V4")

new_tags = data.frame ( artist_id = new_tags$V1, tag_id = new_tags$id, weigth = new_tags$count)

new_tags = new_tags[order(new_tags$artist_id, new_tags$tag_id),]

write.table(new_tags, file="tags.tsv", col.names = T, row.names = F, sep="\t",)




new_tag = aggregate(new_tags, by=list(new_tags$artist_id), FUN=length)
x = unique(new_tags$artist_id, new_tags$tag_id, new_tags$)


new_tag = aggregate(.~artist_id, new_tags, FUN=head, 10)
setkey(new_tags,artist_id)
new_tag = new_tags[,lapply(.artist_id,function(x) head(x,10)),by = key(new_tags)]
