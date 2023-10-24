extends CanvasLayer

var towerAdd := preload("res://scenes/towerAdd.tscn")


func _ready():
	for i in range(12):
		var towerAddInstance = towerAdd.instantiate()
		var tower = load("res://scenes/tower/tower" + str(i + 1) + "/tower" + str(i + 1) + ".tscn")		
		towerAddInstance.tower = tower		
		towerAddInstance.towerId = i + 1
		$Panel/Inventory.add_child(towerAddInstance)
