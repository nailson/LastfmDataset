#!/usr/local/bin/python
# -*- coding: ascii -*-
import os
import requests
import json
import time
import sys

api_key = '592caeca2bae6d0bf5a7a4c50038f842'
limit_per_page = 500
method = 'user.gettoptracks'
page_number = 1
user_id = 'rj'

def escapeSpecialCharacters(text, characters):
    for character in characters:
        text = text.replace("\\", "")
    return text


def read_the_dataset(the_dataset_file):

	with file(the_dataset_file,'r') as infile:
		f = open('/home/nailson/Documents/LastFm Data/coleta.txt', 'a')
        
 
		for line in infile:   
			line = line.rstrip('\n') 
			split_line = line.split('\t')
			final_line = ""
			for column in split_line:
				final_line += escapeSpecialCharacters(column,'\'"')+'\t'
			final_line = final_line.rstrip('\t') 
			f.write(final_line+'\n')
		f.close();


# Execution flow starts here ...
if __name__ == "__main__":

	# Read the training file
	#tweets = read_the_dataset('data/training.dat')
	#tweetsTeste = read_the_dataset('data/test_empty.dat')

	# Read the _empty file (the task)
    
	read_the_dataset('/home/nailson/Documents/LastFm Data/tracks_coleta/coleta.txt')
	#getTracks_by_User('dr')

	print 'done.'

