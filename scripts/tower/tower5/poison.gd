extends Area2D


func _ready():
	self.global_position = get_parent().global_position
	self.scale = Vector2(0, 0)
	var tween = create_tween().set_trans(Tween.TRANS_CIRC)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.4)
	await get_tree().create_timer(0.4).timeout
	tween = create_tween().set_trans(Tween.TRANS_CIRC)
	tween.tween_property(self, "modulate:a", 0, 0.4)
	await get_tree().create_timer(0.4).timeout
	queue_free()


func _on_body_entered(body):
	if body.poisonDuration == -1:
		body.poisonDuration = 240 * Data.towerData[5]["stats"]["duration"][Data.towerData[5]["level"]]
