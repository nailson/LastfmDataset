import pygal # First import pygal
import itertools
import os
import json
import time
import sys

from pygal.style import SolidColorStyle 

def read_the_dataset(the_dataset_file):
	streetno = dict()

	with open(the_dataset_file,'r') as infile:
		
		for line in infile:   
			line = line.rstrip('\n')
			line_split = line.split('\t');
			if (line_split[0] in streetno.keys()):
				streetno[line_split[0]].append(float(line_split[1]))
			else:
				streetno[line_split[0]] = [float(line_split[1])]

	dot_chart = pygal.Dot( x_label_rotation=30, style=SolidColorStyle, show_legend=False, 
		truncate_label=17, spacing=50)
	dot_chart.title = 'PLOT DOT POINTS'
	dot_chart.x_labels = ['0', '1', '2', '3', '4', '5', '6']

	for key in streetno.keys():
		dot_chart.add(key, streetno[key])
		print(key+"\t")
		print(streetno[key])

	#dot_chart.render()
	dot_chart.render_to_file('dot_chart2.svg') 
	#dot_chart.render_to_png('bar_chart2.png')


if __name__ == "__main__":

	read_the_dataset('input.tsv')
	#getTracks_by_User('dr')

	print ('done.')
