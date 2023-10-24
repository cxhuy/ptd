extends Node2D

# Number of towers required for upgrading level
const upgradeRequired: Array[int] = [0, 0, 2, 4, 10, 20, 50, 100, 200]

## Number of towers in inventory
#var towerQuantity: Array[int] = [3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
#
## Level of each towers
#var towerLevels: Array[int] = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]

# Tower Data
var towerData: Dictionary = {
	1: {
		"name": "Explosion Tower",
		"description": "Causes an explosion that damages nearby enemies",
		
		"level": 1,
		"quantity": 3,
		
		"stats": {
			"damage": 10,
		}
	},
	2: {
		"name": "Lightning Tower",
		"description": "Shoots a chain of lightning that damages multiple enemies",	
		
		"level": 1,
		"quantity": 3,
		
		"stats": {
			"damage": 10,
			"targetEnemies": 5,
		}
	}
}
