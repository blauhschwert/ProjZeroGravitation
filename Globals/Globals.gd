class_name Globals
extends Node

static var drop_table = [
	{ "item" : "CommonBuff", "weight" : 60},
	{ "item" : "UncommonBuff", "weight" : 25},
	{ "item" : "RareBuff", "weight" : 10},
	{ "item" : "EpicBuff", "weight" : 4},
	{ "item" : "LegendaryBuff", "weight" : 1},
]

static func pick_drop(table):
	var total_weight = 0
	for e in table:
		total_weight += e.weight
	
	var r = randf() * total_weight
	var comulative = 0

	for e in table:
		comulative += e.weight
		if r < comulative:
			return e.item
	
	return table[-1].item
