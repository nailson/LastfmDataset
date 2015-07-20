#!/usr/local/bin/python
# -*- coding: ascii -*-
import os
import requests
import json
import time
import sys

api_key = '592caeca2bae6d0bf5a7a4c50038f842'
limit_per_page = 200
method = 'user.getTopArtists'
page_number = 1
user_id = 'rj'


def read_the_dataset(the_dataset_file):

	with file(the_dataset_file,'r') as infile:
		f = open('/home/nailson/Documentos/coleta.txt', 'a')
        
        	#f.write("\"userName\"\t\"artistName\"\t\"artistMbid\"\t\"artistUrl\"\t\"playcount\"\t\"rank\"\n")

		for line in infile:   
			userName = line.rstrip('\n') 
			print(userName)
			getTracks_by_User(userName,f)
		f.close();

def getTracks_by_User(userName, f):	
	totalPages = 1

	#for i in range(1,totalPages+1):
	i=1
	while (i <= totalPages):

		page_number = i
		
		user_id = userName
		#print(user_id.rstrip('\n'))
		string_request = 'http://ws.audioscrobbler.com/2.0/?method=user.getTopArtists&user='+user_id+'&api_key='+ api_key
		options = ""
		options += '&format=json'
		options += '&limit=' + str(limit_per_page)

		#print(string_request)
		print(string_request + options + '&page=' + str(page_number))

		try:
			r = requests.get(string_request + options + '&page=' + str(page_number) )
		except requests.exceptions.ConnectionError:
			time.sleep(5)
			continue

		i += 1
		if(r.text == "" or r.text == '""'):
			print('EMPTY')
			continue
		
		if 'error' in r.text:
			print('ERROR')
			#print(r.text)
			continue
		

		jsonResult = json.loads(unicode(r.text).encode('ascii', 'ignore'))
		
		#print(jsonResult)

		if jsonResult == '':
			print('json fail')
			continue

		if jsonResult.has_key('topartists') == True:
		
			if 'artist' not in r.text:
				print('NO TRACK')
				#print(r.text)
				continue
			if 'name' not in r.text:
				print('NO NAME')
				#print(r.text)
				continue
		
			total_elements = jsonResult['topartists']['@attr']['total']
			totalPages = int(jsonResult['topartists']['@attr']['totalPages'])
			print(totalPages)
			#totalPages = 1;
			#print(jsonResult['toptracks']['track']['name'])
			for artist in jsonResult['topartists']['artist']:
				try:
					#print('trackName '+track )
					artistName = str(unicode( artist['name'] ).encode('ascii', 'ignore'))
					artistPlaycount = artist['playcount']
					artistMbid = artist['mbid']
					artistUrl =  str(unicode( artist['url'] ).encode('ascii', 'ignore'))
					artistRank = artist['@attr']['rank']

					f.write(userName+"\t"+artistName+"\t"+artistMbid+"\t"+artistUrl+"\t"+artistPlaycount+"\t"+artistRank+"\n")

				except(IndexError,TypeError):
					artistName = str(unicode( jsonResult['topartists']['artist']['name'] ).encode('ascii', 'ignore'))
					artistPlaycount = jsonResult['topartists']['artist']['playcount']
					artistMbid = jsonResult['topartists']['artist']['mbid']
					artistUrl =  str(unicode( jsonResult['topartists']['artist']['url'] ).encode('ascii', 'ignore'))
					artistRank = jsonResult['topartists']['artist']['@attr']['rank']

					f.write(userName+"\t"+artistName+"\t"+artistMbid+"\t"+artistUrl+"\t"+artistPlaycount+"\t"+artistRank+"\n")
					continue

			time.sleep(0.4)

		else:
			time.sleep(2)
		
        

# Execution flow starts here ...
if __name__ == "__main__":

	# Read the training file
	#tweets = read_the_dataset('data/training.dat')
	#tweetsTeste = read_the_dataset('data/test_empty.dat')

	# Read the _empty file (the task)
    
	read_the_dataset('all_usernames2.tsv')
	#getTracks_by_User('dr')

	print 'done.'

