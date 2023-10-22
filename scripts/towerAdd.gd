extends Panel

var tower := preload("res://scenes/tower/tower.tscn")


func _on_gui_input(event):
	var towerInstance := tower.instantiate()
	
	if event is InputEventMouseButton and event.button_mask == 1:
		add_child(towerInstance)
		towerInstance.process_mode = Node.PROCESS_MODE_DISABLED
		
	elif event is InputEventMouseMotion and event.button_mask == 1:
		get_child(1).global_position = event.global_position
		
	elif event is InputEventMouseButton and event.button_mask == 0:
		var dropPos: Vector2 = get_child(1).global_position
		get_child(1).queue_free()
		get_tree().get_root().get_node("Game").add_child(towerInstance)
		towerInstance.set_global_position(dropPos)
