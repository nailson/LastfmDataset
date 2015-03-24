LastFm Data/nova_coleta$ find . -iregex '.*\(tsv\)' -printf '%f\n' | sed -e 's/\..*$//' > ../UserNameLastFM.txt
