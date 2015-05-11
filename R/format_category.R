

categories = data.frame( artist_url= sort(unique(artists_category$V2)))
categories$id = c(1:length(categories$artist_url))

write.table(categories, file = "categories.tsv", sep = "\t",  row.names = FALSE, col.names = FALSE)

new_artists_category = merge(artists_category, categories, by.x="V2", by.y="artist_url")
new_artists_category = new_artists_category[ order(new_artists_category$V1), c("V1","id")]
new_artists_category$weight = rep(1,length(new_artists_category$id))

write.table(new_artists_category, file = "artists_category2.tsv", sep = "\t",  row.names = FALSE, col.names = FALSE)
