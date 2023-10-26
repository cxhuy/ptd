extends Node2D

var currentStage: int = 1
var currentWave: int = 1
var currentHealth: int = 5

var towerLimit: int = 3
var ballDamage: int = 5
var tankLimit: int = 3

# Number of towers required for upgrading level
const upgradeRequired: Array[int] = [0, 2, 4, 10, 20, 50, 100, 200, 400]

const rewards: Dictionary = {
	1: {
		3: {
			"totalTowersReward": 10,
			"totalTowersUnlocked": 1
		},
		6: {
			"totalTowersReward": 20,
			"totalTowersUnlocked": 2
		},
		9: {
			"totalTowersReward": 30,
			"towerLimitIncrease": 1,
			"ballDamageIncrease": 5,
			"tankLimitIncrease": 1
		}
	},
	2: {
		3: {
			"totalTowersReward": 10,
			"totalTowersUnlocked": 1
		},
		6: {
			"totalTowersReward": 20,
			"totalTowersUnlocked": 2
		},
		9: {}
	},
}


# Tower Data
var towerData: Dictionary = {
	1: {
		"name": "Explosion Tower",
		"description": "Causes an explosion that damages nearby enemies",
		
		"level": 1,
		"quantity": 3,
		
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
			"damage": [0, 10, 12, 15, 18, 22, 27, 33, 40, 50],
		},
		
		"unlocked": false
	},
	4: {
		"name": "Sniper Tower",
		"description": "Fires a bullet that becomes stronger as it travels (Max 2X)",
		
		"level": 1,
		"quantity": 0,
		
		"stats": {
			"damage": [0, 10, 12, 15, 18, 22, 27, 33, 40, 50],
		},
		
		"unlocked": false
	},
	5: {
		"name": "Poison Tower",
		"description": "Poisons nearby enemies",
		
		"level": 1,
		"quantity": 0,
		
		"stats": {
			"damage": [0, 10, 12, 15, 18, 22, 27, 33, 40, 50],
			"duration": [0, 3, 3, 3, 4, 4, 4, 5, 5, 6],
		},
		
		"unlocked": false
	},
	6: {
		"name": "Comet Tower",
		"description": "Adds a comet to its orbit (Max 6 stacks)",
		
		"level": 1,
		"quantity": 0,
		
		"stats": {
			"damage": [0, 10, 12, 15, 18, 22, 27, 33, 40, 50],
		},
		
		"unlocked": false
	},
	7: {
		"name": "Teleport Tower",
		"description": "Has a chance of teleporting enemies behind",
		
		"level": 1,
		"quantity": 0,
		
		"stats": {
			"distance": [0, 300, 325, 350, 375, 400, 450, 500, 550, 600],
			"probability": [0, 35, 40, 45, 50, 55, 60, 65, 70, 75],
		},
		
		"unlocked": false
	},
	8: {
		"name": "Black Hole Tower",
		"description": "Damages every enemy on the screen when the number hits zero",
		
		"level": 1,
		"quantity": 0,
		
		"stats": {
			"damage": [0, 50, 75, 100, 125, 150, 200, 250, 350, 400],
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

var enemyData: Dictionary = {
	1: {
		1: {"speed": 100, "health": 100},
		2: {"speed": 100, "health": 200},
		3: {"speed": 100, "health": 300},
		4: {"speed": 100, "health": 400},
		5: {"speed": 100, "health": 500},
		6: {"speed": 100, "health": 600},
		7: {"speed": 100, "health": 700},
		8: {"speed": 100, "health": 800},
	},
	2: {
		1: {"speed": 400, "health": 30},
		2: {"speed": 400, "health": 60},
		3: {"speed": 400, "health": 90},
		4: {"speed": 400, "health": 120},
		5: {"speed": 400, "health": 150},
		6: {"speed": 400, "health": 180},
		7: {"speed": 400, "health": 210},
		8: {"speed": 400, "health": 240},
	},
	3: {
		1: {"speed": 200, "health": 50},
		2: {"speed": 200, "health": 100},
		3: {"speed": 200, "health": 150},
		4: {"speed": 200, "health": 200},
		5: {"speed": 200, "health": 250},
		6: {"speed": 200, "health": 300},
		7: {"speed": 200, "health": 350},
		8: {"speed": 200, "health": 400},
	}
}
