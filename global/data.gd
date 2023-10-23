extends Node2D

var towerQuantity: Array[int] = [3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

var towerStats: Dictionary = {
	1: {
		"damage": 10
	},
	2: {
		"damage": 5,
		"targetEnemies": 5
	}
}
