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
method = 'artist.getTopTags'
page_number = 1
user_id = 'rj'


def read_the_dataset(the_dataset_file):

	with file(the_dataset_file,'r') as infile:
		f = open('/home/nailson/Documentos/tags.txt', 'a')
        
        	#f.write("artistMbid\"\t\"tagname\"\t\"tagcount\"\t\"tagurl\"\n")

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
		
		string_request = 'http://ws.audioscrobbler.com/2.0/?method=' + method + '&artist='+artistMbid + '&api_key='+ api_key
		options = ""
		options += '&format=json'
		options += '&limit=' + str(limit_per_page)

		#print(string_request + options + '&page=' + str(page_number))
		r = requests.get(string_request + options + '&page=' + str(page_number) )
		
		if(r.text == "" or r.text == '""'):
			continue
		
		'''if 'error' in r.text:
			print(artistMbid)
			continue'''
		

		jsonResult = json.loads(unicode(r.text).encode('ascii', 'ignore'))
		
		#print(jsonResult)

		if jsonResult == '':
			print('json fail')
			continue

		if jsonResult.has_key('toptags') == True:
		
			if 'tag' not in r.text:
				print(artistMbid)
				#print(r.text)
				continue
			if 'count' not in r.text:
				print(artistMbid)
				#print(r.text)
				continue
			if 'url' not in r.text:
				print(artistMbid)
				#print(r.text)
				continue
		
			totalPages = 1;
			'''try:
				tagName = str(unicode( jsonResult['toptags']['tag']['name'] ).encode('ascii', 'ignore'))
				tagCount =  jsonResult['toptags']['tag']['count']
				tagUrl =  str(unicode(  jsonResult['toptags']['tag']['url'] ).encode('ascii', 'ignore'))
				f.write(artistMbid+"\t"+tagName+"\t"+tagCount+"\t"+tagUrl+"\n")
			except(IndexError,TypeError):
					print(artistMbid)
					continue'''
			#print(jsonResult['toptracks']['track']['name'])
			for tag in jsonResult['toptags']['tag']:
				try:
					#print('trackName '+track )
					tagName = str(unicode( tag['name'] ).encode('ascii', 'ignore'))
					tagCount = tag['count']
					tagUrl =  str(unicode( tag['url'] ).encode('ascii', 'ignore'))
					f.write(artistMbid+"\t"+tagName+"\t"+tagCount+"\t"+tagUrl+"\n")
				
				except(IndexError,TypeError):
					print("Index")
					#print(artistMbid)
					continue
			#time.sleep(0.1)

		else:
			time.sleep(10)
		
        

# Execution flow starts here ...
if __name__ == "__main__":

	# Read the training file
	#tweets = read_the_dataset('data/training.dat')
	#tweetsTeste = read_the_dataset('data/test_empty.dat')

	# Read the _empty file (the task)
    
	read_the_dataset('not_tags_name.tsv')
	#getTracks_by_User('dr')

	print 'done.'

