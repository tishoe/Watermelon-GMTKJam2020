extends Node

var current_level = 1

var levelData = [
	{ #level 1
		"forced_moves": {2: Vector2.DOWN},
		"total_moves": 12
	},
	{ #level 2
		"forced_moves": {6: Vector2.RIGHT},
		"total_moves": 9
	},
	{ #level 3
		"forced_moves": {3: Vector2.UP, 10: Vector2.DOWN},
		"total_moves": 13
	},
	{ #level 4
		"forced_moves": {12: Vector2.UP, 15: Vector2.DOWN, 17: Vector2.LEFT},
		"total_moves": 18
	},
	{ #level 5
		"forced_moves": {6: Vector2.RIGHT, 10: Vector2.RIGHT, 12: Vector2.RIGHT,
						 16: Vector2.UP, 17: Vector2.UP, 18: Vector2.RIGHT, 19: Vector2.RIGHT},
		"total_moves": 21
	},
	{ #level 6
		"forced_moves": {7: Vector2.LEFT, 8: Vector2.LEFT, 10: Vector2.UP, 18: Vector2.RIGHT,
						 19: Vector2.DOWN, 31: Vector2.RIGHT, 48: Vector2.DOWN, 50: Vector2.LEFT},
		"total_moves": 56
	},
	{ #level 7
		"forced_moves": {2: Vector2.LEFT, 18: Vector2.LEFT},
		"box_moves": {2: Vector2.LEFT, 18: Vector2.LEFT},
		"total_moves": 24
	},
	{ #level 8
		"forced_moves": {3: Vector2.LEFT, 4: Vector2.UP, 5:Vector2.UP,
						 9:Vector2.LEFT, 10:Vector2.LEFT, 11:Vector2.LEFT, 
						 12:Vector2.LEFT,
						 21:Vector2.UP, 22:Vector2.UP, 23:Vector2.UP,
						 24:Vector2.LEFT, 25:Vector2.LEFT, 26:Vector2.LEFT,
						 36: Vector2.DOWN},
		"box_moves": {36: Vector2.DOWN},
		"total_moves": 40
	}]
	
func get_level_data(): 
	if current_level <= levelData.size():
		return levelData[current_level - 1]
	else:
		return {
		"forced_moves": {},
		"total_moves": 99
	}
