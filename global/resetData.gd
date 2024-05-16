extends Node

var currentStage: int = 1
var currentWave: int = 1
var currentHealth: int = 5

var towerLimit: int = 2
var ballDamage: int = 5
var tankLimit: int = 3

var towerData: Dictionary = {
	1: {
		"name": "Explosion Tower",
		"description": "Causes an explosion that damages nearby enemies",

		"level": 1,
		"quantity": 2,

		"stats": {
			"damage": [0, 10, 15, 20, 25, 30, 40, 55, 75, 100]
		},

		"unlocked": true
	},
	2: {
		"name": "Lightning Tower",
		"description": "Shoots a chain of lightning that damages multiple enemies",

		"level": 1,
		"quantity": 0,

		"stats": {
			"damage": [0, 10, 12, 15, 18, 22, 27, 33, 40, 50],
			"targetEnemies": [0, 3, 3, 4, 4, 5, 6, 7, 8, 10],
		},

		"unlocked": false
	},
	3: {
		"name": "Light Tower",
		"description": "Shoots a beam of light",

		"level": 1,
		"quantity": 0,

		"stats": {
			"damage": [0, 10, 15, 20, 25, 30, 40, 55, 75, 100],
		},

		"unlocked": false
	},
	4: {
		"name": "Sniper Tower",
		"description": "Fires a bullet that becomes stronger as it travels (Max 2X)",

		"level": 1,
		"quantity": 0,

		"stats": {
			"damage": [0, 10, 15, 20, 35, 50, 70, 90, 120, 175],
		},

		"unlocked": false
	},
	5: {
		"name": "Poison Tower",
		"description": "Poisons nearby enemies",

		"level": 1,
		"quantity": 0,

		"stats": {
			"damage": [0, 3, 3, 4, 5, 6, 9, 12, 15, 20],
			"duration": [0, 5, 6, 6, 6, 7, 7, 7, 8, 10],
		},

		"unlocked": false
	},
	6: {
		"name": "Comet Tower",
		"description": "Adds a comet to its orbit (Max 6 stacks)",

		"level": 1,
		"quantity": 0,

		"stats": {
			"damage": [0, 5, 6, 8, 10, 13, 16, 20, 24, 30],
		},

		"unlocked": false
	},
	7: {
		"name": "Teleport Tower",
		"description": "Has a chance of teleporting enemies behind",

		"level": 1,
		"quantity": 0,

		"stats": {
			"distance": [0, 300, 320, 345, 375, 415, 460, 510, 565, 620],
			"probability": [0, 35, 40, 40, 45, 45, 50, 50, 55, 60],
		},

		"unlocked": false
	},
	8: {
		"name": "Black Hole Tower",
		"description": "Damages every enemy on the screen when the number hits zero",

		"level": 1,
		"quantity": 0,

		"stats": {
			"damage": [0, 20, 25, 30, 30, 40, 50, 55, 70, 80],
			"hitsNeeded": [0, 6, 6, 6, 5, 5, 5, 4, 4, 3],
		},

		"unlocked": false
	},
#	9: {
#		"name": "Ice Tower",
#		"description": "Slows down nearby enemies",
#
#		"level": 1,
#		"quantity": 0,
#
#		"stats": {},
#
#		"unlocked": false
#	},
#	10: {
#		"name": "Shotgun Tower",
#		"description": "Shoots three powerful bullets",
#
#		"level": 1,
#		"quantity": 0,
#
#		"stats": {},
#
#		"unlocked": false
#	},
}


#func _ready():
#	currentStage = Data.currentStage
#	currentWave = Data.currentWave
#	currentHealth = Data.currentHealth
#
#	towerLimit = Data.towerLimit
#	ballDamage = Data.ballDamage
#	tankLimit = Data.tankLimit
#
#	towerData = Data.towerData.duplicate(true)


func resetData():
	Data.currentStage = currentStage
	Data.currentWave = currentWave
	Data.currentHealth = currentHealth

	Data.towerLimit = towerLimit
	Data.ballDamage = ballDamage
	Data.tankLimit = tankLimit

	Data.towerData = towerData.duplicate(true)

	get_tree().change_scene_to_file("res://scenes/game.tscn")
	get_tree().reload_current_scene()
