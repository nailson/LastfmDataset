#!/usr/local/bin/python
# -*- coding: ascii -*-
import os
import requests
import json
import time
import sys
import urllib2 as ul


api_key = '592caeca2bae6d0bf5a7a4c50038f842'
limit_per_page = 100
method = 'artist.getInfo'
page_number = 1
user_id = 'rj'


def read_the_dataset(the_dataset_file):

	with file(the_dataset_file,'r') as infile:
		f = open('/home/nailson/Documentos/artist_info.txt', 'a')
        
        	#f.write("artistMbid\"\t\"mbid\"\t\"url\"\t\"listeners\"\t\"playcount\"\n")

		for line in infile:   
			artistMbid = line.rstrip('\n') 
			#print(artistMbid)
			getTracks_by_User(artistMbid,f)
		f.close();

def getTracks_by_User(artistMbid, f):	
	totalPages = 1
	artistMbid = ul.quote(artistMbid)
	#for i in range(1,totalPages+1):
	i=1
	while (i <= 1):

		page_number = i
		i += 1
		
		string_request = 'http://ws.audioscrobbler.com/2.0/?method=' + method + '&mbid='+artistMbid + '&api_key='+ api_key
		options = ""
		options += '&format=json'
		options += '&limit=' + str(limit_per_page)

		#print(string_request + options + '&page=' + str(page_number))
		r = requests.get(string_request + options + '&page=' + str(page_number) )
		
		if(r.text == "" or r.text == '""'):
			continue
		
		jsonResult = json.loads(unicode(r.text).encode('ascii', 'ignore'))
		
		#print(jsonResult)

		if jsonResult == '':
			print('json fail')
			continue

		if jsonResult.has_key('artist') == True:
		
			if 'mbid' not in r.text:
				print("mbid")
				#print(artistMbid)
				#print(r.text)
				continue
			if 'url' not in r.text:
				print("url")
				#print(artistMbid)
				#print(r.text)
				continue
			if 'stats' not in r.text:
				print("stats")
				#print(artistMbid)
				#print(r.text)
				continue
		
			totalPages = 1;
			
			try:
				name = str(unicode( jsonResult['artist']['name'] ).encode('ascii', 'ignore'))
				url =  str(unicode(  jsonResult['artist']['url'] ).encode('ascii', 'ignore'))
				listeners =  jsonResult['artist']['stats']['listeners']
				playcount =  jsonResult['artist']['stats']['playcount']
				#print(name+"\t"+artistMbid+"\t"+url+"\t"+listeners+"\t"+playcount+"\n")
				f.write(artistMbid+"\t"+name+"\t"+url+"\t"+listeners+"\t"+playcount+"\n")
			except(IndexError,TypeError):
					print("IndexError")
					continue

		else:
			print("Else")
		
        

# Execution flow starts here ...
if __name__ == "__main__":

	# Read the training file
	#tweets = read_the_dataset('data/training.dat')
	#tweetsTeste = read_the_dataset('data/test_empty.dat')

	# Read the _empty file (the task)
    
	read_the_dataset('mbid.tsv')
	#getTracks_by_User('dr')

	print 'done.'
