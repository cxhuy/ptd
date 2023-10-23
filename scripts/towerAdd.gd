extends Panel

var tower
var towerId


func _ready():
	$TowerSprite.texture = \
		load("res://sprites/towers/tower" + str(towerId) + "/tower" + str(towerId) + "_ui.svg")
	$TowerQuantity.text = "x" + str(Data.towerQuantity[towerId - 1])


func _on_gui_input(event):
	var towerInstance
	
	if event is InputEventMouseButton:
		towerInstance = tower.instantiate()
		
	if event is InputEventMouseButton and event.button_mask == 1:
		add_child(towerInstance)
		towerInstance.process_mode = Node.PROCESS_MODE_DISABLED
		
	elif event is InputEventMouseMotion and event.button_mask == 1:
		get_child(2).global_position = event.global_position
		
	elif event is InputEventMouseButton and event.button_mask == 0:
		var dropPos: Vector2 = get_child(2).global_position
		get_child(2).queue_free()
		if Data.towerQuantity[towerId - 1] > 0:		
			get_tree().get_root().get_node("Game").add_child(towerInstance)
			towerInstance.set_global_position(dropPos)
			towerInstance.get_node("AttackRange/AttackRangeVisual").hide()
			Data.towerQuantity[towerId - 1] -= 1
			$TowerQuantity.text = "x" + str(Data.towerQuantity[towerId - 1])
