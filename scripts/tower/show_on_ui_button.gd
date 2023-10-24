extends Button


func _on_pressed():
	get_tree().get_root().get_node("Game/UI").updateTowerData(get_parent().towerId, get_parent())


func _on_mouse_entered():
	get_parent().get_node("AttackRange/AttackRangeVisual").show()


func _on_mouse_exited():
	get_parent().get_node("AttackRange/AttackRangeVisual").hide()
