artists_musicbrainz = read.table("../data/artists_musicbrainz_dbpedia_link.txt", quote=" ")


artists_musicbrainz$mbid =  substr(x = artists_musicbrainz$V1, start = 32, stop = 67)

merged_dbpedia = merge(x = dataset_artists, y = artists_musicbrainz, by.x = "V3", By.y="mbid")
