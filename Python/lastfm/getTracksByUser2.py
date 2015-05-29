import requests
import json
import time
import sys

api_key = '592caeca2bae6d0bf5a7a4c50038f842'
limit_per_page = 2
method = 'user.gettoptracks'
page_number = 1
user_id = 'rj'


def read_the_dataset(the_dataset_file):

	with file(the_dataset_file,'r') as infile:

		for line in infile:   
			userName = line.rstrip('\n') 
			print(userName)
			getTracks_by_User(userName)


def getTracks_by_User(userName):
	
	totalPages = 1
	
	f = open('/home/nailson/Documents/LastFm Data/tracks_coleta/'+userName, 'w+')
        
        f.write("\"trackName\"\t\"trackDuration\"\t\"trackMbid\"\t\"trackUrl\"\t\"trackRank\"\t\"artistName\"\t\"artistMbid\"\t\"artistUrl\"\n")
        

	#for i in range(1,totalPages+1):
	i=1
	while (i <= totalPages):

		page_number = i
		i += 1
		user_id = userName
		string_request = 'http://ws.audioscrobbler.com/2.0/?method=' + method + '&user='+user_id + '&api_key='+ api_key
		options = ""
		options += '&format=json'
		options += '&limit=' + str(limit_per_page)

		print(string_request + options + '&page=' + str(page_number))
		r = requests.get(string_request + options + '&page=' + str(page_number) )

		jsonResult = json.loads(r.text)
		#print(r.text)
	
		if jsonResult.has_key('error') == True:
			print('ERROR')
			return None
	
	
		if jsonResult.has_key('toptracks') == True:
		
			if 'track' not in r.text:
				print('NO TRACK')
				return None
			if 'name' not in r.text:
				print('NO NAME')
				return None
		
			total_elements = jsonResult['toptracks']['@attr']['total']
			totalPages = jsonResult['toptracks']['@attr']['totalPages']
	

			for track in jsonResult['toptracks']['track']:
			
				trackName = track['name']
				trackDuration = track['duration']
				trackPlaycount = track['playcount']
				trackMbid = track['mbid']
				trackUrl = track['url']
				trackRank = track['@attr']['rank']
				artistName = track['artist']['name']
				artistMbid = track['artist']['mbid']
				artistUrl = track['artist']['url']
				f.write(trackName+"\t"+trackDuration+"\t"+trackMbid+"\t"+trackUrl+"\t"+trackRank+"\t")
				f.write(artistName+"\t"+artistMbid+"\t"+artistUrl+"\n")

		else:
			time.sleep(10)
        f.close();



# Execution flow starts here ...
if __name__ == "__main__":
	# Read the training file
	#tweets = read_the_dataset('data/training.dat')
	#tweetsTeste = read_the_dataset('data/test_empty.dat')

	# Read the _empty file (the task)
    
	read_the_dataset('LastFM Dataset/UserNameLastFM.txt')
	#getTracks_by_User('dr')
 

	print 'done.'



"""
is_last_page = False

if page_number == totalPages:
		is_last_page = True

	if is_last_page == True:
		range_page = int(total_elements)%limit_per_page
	else:
		range_page = limit_per_page

	#for i in range(0, range_page):
		#print (i)
		
	#	if(range_page == 1):
			#jsonResultTrack = jsonResult['toptracks']['track']
			#print(jsonResult['toptracks']['track']['name'])
			#print(jsonResult['toptracks']['track']['duration'])
			#print(jsonResult['toptracks']['track']['playcount'])
			#print(jsonResult['toptracks']['track']['mbid'])
			#print(jsonResult['toptracks']['track']['url'])

	#	else:
			#jsonResultTrack = jsonResult['toptracks'][i]['track']
			#print(jsonResult['toptracks']['track'][i]['name'])
			#print(jsonResult['toptracks']['track'][i]['duration'])
			#print(jsonResult['toptracks']['track'][i]['playcount'])
			#print(jsonResult['toptracks']['track'][i]['mbid'])
			#print(jsonResult['toptracks']['track'][i]['url'])
		#print(jsonResultTrack['name'])
		#print(jsonResultTrack['duration'])
		#print(jsonResultTrack['playcount'])
		#print(jsonResultTrack['mbid'])
		#print(jsonResultTrack['url'])


"""

"""
				print track['name'],
				print track['duration'],
				print track['playcount'],
				print track['mbid'],
				print track['url'],
				print track['@attr']['rank'],
				print track['artist']['name'],
				print track['artist']['mbid'],
				print track['artist']['url'],
"""
