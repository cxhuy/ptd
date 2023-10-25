extends Panel

var tower
var towerId


func _ready():
	$TowerSprite.texture = \
		load("res://sprites/towers/locked.svg")


func _on_gui_input(event):
	var towerInstance
	
	if event is InputEventMouseButton:
		towerInstance = tower.instantiate()
		
	if event is InputEventMouseButton and event.button_mask == 1:
		get_node("../../../TowerLimit").show()
		get_node("../../../TowerLimit").text = \
			str(get_tree().get_nodes_in_group("Towers").size()) + " / " + str(Data.towerLimit)	
		if get_tree().get_nodes_in_group("Towers").size() < Data.towerLimit:
			get_node("../../../TowerLimit").modulate = Color("00000064")
		else:
			get_node("../../../TowerLimit").modulate = Color("ff000064")
		get_node("../../../").updateTowerData(towerId)		
		if Data.towerData[towerId]["quantity"] > 0:
			add_child(towerInstance)
#			towerInstance.process_mode = Node.PROCESS_MODE_DISABLED
		
	elif event is InputEventMouseMotion and event.button_mask == 1 and Data.towerData[towerId]["quantity"] > 0:
		get_child(2).global_position = event.global_position
		
	elif event is InputEventMouseButton and event.button_mask == 0 and Data.towerData[towerId]["quantity"] > 0:
		get_node("../../../TowerLimit").hide()
		var dropPos: Vector2 = get_child(2).global_position
		var placementAllowed: bool = get_child(2).towerPlacementAllowed
		get_child(2).queue_free()
		if placementAllowed and get_tree().get_nodes_in_group("Towers").size() <= Data.towerLimit and \
		Data.towerData[towerId]["quantity"] > 0:		
			get_tree().get_root().get_node("Game").add_child(towerInstance)
			towerInstance.get_node("ShowOnUIButton").set_mouse_filter(0)
			towerInstance.set_global_position(dropPos)
			towerInstance.get_node("AttackRange/AttackRangeVisual").hide()
			towerInstance.towerPlaced = true
			Data.towerData[towerId]["quantity"] -= 1
			$TowerQuantity.text = "x" + str(Data.towerData[towerId]["quantity"] )
			get_node("../../../").updateTowerData(towerId)
