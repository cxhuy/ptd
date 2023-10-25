extends Node2D

var currentStage: int = 1
var currentWave: int = 1
var currentHealth: int = 5
var towerLimit: int = 3

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
		9: {}
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
		"quantity": 1000,
		
		"stats": {
			"damage": [10, 15, 20, 25, 30, 40, 55, 75, 100]
		},
		
		"unlocked": true
	},
	2: {
		"name": "Lightning Tower",
		"description": "Shoots a chain of lightning that damages multiple enemies",	
		
		"level": 1,
		"quantity": 1000,
		
		"stats": {
			"damage": [10, 12, 15, 18, 22, 27, 33, 40, 50],
			"targetEnemies": [3, 3, 4, 4, 5, 6, 7, 8, 10],
		},
		
		"unlocked": false
	},
	3: {
		"name": "Light Tower",
		"description": "Shoots a beam of light",
		
		"level": 1,
		"quantity": 1000,
		
		"stats": {},
		
		"unlocked": false
	},
	4: {
		"name": "Sniper Tower",
		"description": "Fires a bullet that becomes stronger as it travels (Max 2X)",
		
		"level": 1,
		"quantity": 1000,
		
		"stats": {},
		
		"unlocked": false
	},
	5: {
		"name": "Poison Tower",
		"description": "Poisons nearby enemies",
		
		"level": 1,
		"quantity": 1000,
		
		"stats": {},
		
		"unlocked": false
	},
	6: {
		"name": "Comet Tower",
		"description": "Adds a comet to its orbit (Max 6 stacks)",
		
		"level": 1,
		"quantity": 1000,
		
		"stats": {},
		
		"unlocked": false
	},
}
