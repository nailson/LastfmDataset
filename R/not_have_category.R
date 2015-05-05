
not_has_category = artists_url[!(artists_url$V1%in%artists_category$V1),]

write.table(not_has_category, file="not_have_category.tsv", row.name=F, col.name=F, quote=F)
