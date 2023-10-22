extends Area2D


func _ready():
	self.scale = Vector2(0, 0)
	var tween = create_tween().set_trans(Tween.TRANS_CIRC)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.2)	
	await get_tree().create_timer(0.2).timeout
	tween = create_tween().set_trans(Tween.TRANS_CIRC)
	tween.tween_property(self, "modulate:a", 0, 0.2)	
	await get_tree().create_timer(0.2).timeout
	queue_free()
