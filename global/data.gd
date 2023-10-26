extends Node2D

var currentStage: int = 1
var currentWave: int = 1
var currentHealth: int = 5

var towerLimit: int = 2
var ballDamage: int = 5
var tankLimit: int = 3

# Number of towers required for upgrading level
const upgradeRequired: Array[int] = [0, 2, 4, 10, 20, 50, 100, 200, 400]

const rewards: Dictionary = {
	1: {
		3: {
			"totalTowersReward": 10,
			"totalTowersUnlocked": 1,
		},
		6: {
			"totalTowersReward": 20,	
			"towerLimitIncrease": 1,				
			"totalTowersUnlocked": 2,
		},
		9: {
			"totalTowersReward": 30,
			"towerLimitIncrease": 1,
			"ballDamageIncrease": 5,
			"tankLimitIncrease": 1,
		}
	},
	2: {
		3: {
			"totalTowersReward": 30,
			"totalTowersUnlocked": 1,
		},
		6: {
			"totalTowersReward": 40,
			"towerLimitIncrease": 1,
			"tankLimitIncrease": 1,
		},
		9: {
			"totalTowersReward": 50,
			"totalTowersUnlocked": 2,
		}
	},
	3: {
		3: {
			"totalTowersReward": 50,
			"totalTowersUnlocked": 1,
		},
		6: {
			"totalTowersReward": 60,
			"towerLimitIncrease": 1,
			"tankLimitIncrease": 1,
		},
		9: {
			"totalTowersReward": 70,
			"totalTowersUnlocked": 2,
		}
	},
}


# Tower Data
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
			"damage": [0, 20, 40, 60, 80, 110, 150, 200, 250, 300],
		},
		
		"unlocked": false
	},
	5: {
		"name": "Poison Tower",
		"description": "Poisons nearby enemies",
		
		"level": 1,
		"quantity": 0,
		
		"stats": {
			"damage": [0, 5, 10, 15, 15, 20, 25, 30, 40, 50],
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
		1: {"speed": 100, "health": 30},
		2: {"speed": 100, "health": 40},
		3: {"speed": 100, "health": 60},
		4: {"speed": 100, "health": 80},
		5: {"speed": 100, "health": 100}
	},
	2: {
		1: {"speed": 200, "health": 20},
		2: {"speed": 200, "health": 30},
		3: {"speed": 200, "health": 40},
		4: {"speed": 200, "health": 50},
		5: {"speed": 200, "health": 60}
	},
	3: {
		1: {"speed": 80, "health": 100},
		2: {"speed": 80, "health": 200},
		3: {"speed": 80, "health": 300},
		4: {"speed": 80, "health": 400},
		5: {"speed": 80, "health": 500}
	}
}

# Enemy Type, Enemy Id, Enemy Count, Spawn Delay
var waveData: Dictionary = {
	1: {
		1: [[1, 1, 20, 1]],
		2: [[1, 1, 14, 1],[1, 1, 1, 3],[1, 1, 15, 1]],
		3: [[1, 1, 19, 1],[1, 1, 1, 4],[2, 1, 5, 1]],
		4: [[2, 1, 24, 1],[2, 1, 1, 4],[1, 1, 10, 1]],
		5: [[1, 1, 15, 0.8],[2, 1, 15, 0.8]],
		6: [[2, 1, 9, 1],[2, 1, 1, 3],[1, 1, 9, 1],[1, 1, 1, 3],[3, 1, 3, 1]],
		7: [[2, 1, 10, 1], [1, 1, 10, 1], [3, 1, 10, 1]],
		8: [[3, 1, 15, 0.8], [1, 1, 15, 0.8], [2, 1, 15, 0.8]],
		9: [[1, 1, 20, 0.5], [3, 1, 20, 0.5]],
	},
	2: {
		1: [[1, 2, 20, 1]],
		2: [[1, 2, 14, 1],[1, 2, 1, 3],[1, 2, 15, 1]],
		3: [[1, 2, 19, 1],[1, 2, 1, 4],[2, 2, 5, 1]],
		4: [[2, 2, 24, 1],[2, 2, 1, 4],[1, 2, 10, 1]],
		5: [[1, 2, 15, 0.8],[2, 2, 15, 0.8]],
		6: [[2, 2, 9, 1],[2, 2, 1, 3],[1, 2, 9, 1],[1, 2, 1, 3],[3, 2, 3, 1]],
		7: [[2, 2, 10, 1], [1, 2, 10, 1], [3, 2, 10, 1]],
		8: [[3, 2, 15, 0.8], [1, 2, 15, 0.8], [2, 2, 15, 0.8]],
		9: [[1, 2, 20, 0.5], [3, 2, 20, 0.5]],
	},
	3: {
		1: [[1, 3, 20, 1]],
		2: [[1, 3, 14, 1],[1, 3, 1, 3],[1, 3, 15, 1]],
		3: [[1, 3, 19, 1],[1, 3, 1, 4],[2, 3, 5, 1]],
		4: [[2, 3, 24, 1],[2, 3, 1, 4],[1, 3, 10, 1]],
		5: [[1, 3, 15, 0.8],[2, 3, 15, 0.8]],
		6: [[2, 3, 9, 1],[2, 3, 1, 3],[1, 3, 9, 1],[1, 3, 1, 3],[3, 3, 3, 1]],
		7: [[2, 3, 10, 1], [1, 3, 10, 1], [3, 3, 10, 1]],
		8: [[3, 3, 15, 0.8], [1, 3, 15, 0.8], [2, 3, 15, 0.8]],
		9: [[1, 3, 20, 0.5], [3, 3, 20, 0.5]],
	},
	4: {
		1: [[1, 4, 20, 1]],
		2: [[1, 4, 14, 1],[1, 4, 1, 3],[1, 4, 15, 1]],
		3: [[1, 4, 19, 1],[1, 4, 1, 4],[2, 4, 5, 1]],
		4: [[2, 4, 24, 1],[2, 4, 1, 4],[1, 4, 10, 1]],
		5: [[1, 4, 15, 0.8],[2, 4, 15, 0.8]],
		6: [[2, 4, 9, 1],[2, 4, 1, 3],[1, 4, 9, 1],[1, 4, 1, 3],[3, 4, 3, 1]],
		7: [[2, 4, 10, 1], [1, 4, 10, 1], [3, 4, 10, 1]],
		8: [[3, 4, 15, 0.8], [1, 4, 15, 0.8], [2, 4, 15, 0.8]],
		9: [[1, 4, 20, 0.5], [3, 4, 20, 0.5]],
	},
	5: {
		1: [[1, 5, 20, 1]],
		2: [[1, 5, 14, 1],[1, 5, 1, 3],[1, 5, 15, 1]],
		3: [[1, 5, 19, 1],[1, 5, 1, 4],[2, 5, 5, 1]],
		4: [[2, 5, 24, 1],[2, 5, 1, 4],[1, 5, 10, 1]],
		5: [[1, 5, 15, 0.8],[2, 5, 15, 0.8]],
		6: [[2, 5, 9, 1],[2, 5, 1, 3],[1, 5, 9, 1],[1, 5, 1, 3],[3, 5, 3, 1]],
		7: [[2, 5, 10, 1], [1, 5, 10, 1], [3, 5, 10, 1]],
		8: [[3, 5, 15, 0.8], [1, 5, 15, 0.8], [2, 5, 15, 0.8]],
		9: [[1, 5, 20, 0.5], [3, 5, 20, 0.5]],
	}
}
