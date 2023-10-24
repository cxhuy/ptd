extends Node2D

# Number of towers required for upgrading level
var upgradeRequired: Array[int] = [0, 0, 2, 4, 10, 20, 50, 100, 200]

# Number of towers in inventory
var towerQuantity: Array[int] = [3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

# Level of each towers
var towerLevels: Array[int] = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]

# Stats of towers
var towerStats: Dictionary = {
	1: {
		"damage": 10
	},
	2: {
		"damage": 5,
		"targetEnemies": 5
	}
}
