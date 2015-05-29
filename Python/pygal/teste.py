import pygal # First import pygal
import sys
import argparse
import json
import itertools


from pygal.style import SolidColorStyle 


streetno = dict()

if ("Chrome" in streetno.keys()):
	streetno["Chrome"].append(6395)
	streetno["Chrome"].append(8212)
	streetno["Chrome"].append(7520)
	streetno["Chrome"].append(7218)
	streetno["Chrome"].append(12464)
	streetno["Chrome"].append(1660)
	streetno["Chrome"].append(2123)
	streetno["Chrome"].append(8607)
else:
	streetno["Chrome"] = []


dot_chart = pygal.Dot(x_label_rotation=30, style=SolidColorStyle )
dot_chart.title = 'V8 benchmark results'
dot_chart.x_labels = ['Richards', 'DeltaBlue', 'Crypto', 'RayTrace', 'EarleyBoyer', 'RegExp', 'Splay', 'NavierStokes']

dot_chart.add('Chrome', streetno["Chrome"])

dot_chart.add('Firefox', [7473, 8099, 11700, 2651, 6361, 1044, 3797, 9450])
dot_chart.add('Opera', [3472, 2933, 4203, 5229, 5810, 1828, 9013, 4669])
dot_chart.add('IE', [43, 41, 59, 79, 144, 136, 34, 102])
dot_chart.render()
dot_chart.render_to_file('bar_chart.svg') 
#dot_chart.render_to_png('bar_chart2.png')
