extends Label


func _process(delta):
	if get_tree().get_nodes_in_group("TankBalls").size() > Data.tankLimit:
		get_tree().get_nodes_in_group("TankBalls")[0].queue_free()
	elif get_tree().get_nodes_in_group("TankBalls").size() == Data.tankLimit:
		self.show()
	else:
		self.hide()
