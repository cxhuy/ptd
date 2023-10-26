extends Sprite2D


func _ready():
	for enemy in get_tree().get_nodes_in_group("Enemies"):
		enemy.damage(Data.towerData[8]["stats"]["damage"][Data.towerData[8]["level"]])
	self.global_position = get_parent().global_position
	self.scale = Vector2(0, 0)
	var tween = create_tween().set_trans(Tween.TRANS_CIRC)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.4)	
	await get_tree().create_timer(0.4).timeout
	tween = create_tween().set_trans(Tween.TRANS_CIRC)
	tween.tween_property(self, "modulate:a", 0, 0.4)	
	await get_tree().create_timer(0.4).timeout
	queue_free()
