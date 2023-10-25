extends Area2D


func _ready():
	var tween = create_tween().set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "rotation_degrees", self.rotation_degrees + 60, 1)
	var tween2 = create_tween().set_ease(Tween.EASE_OUT)
	tween2.tween_property(self, "scale", Vector2(2, 2), 1)	
	await get_tree().create_timer(1).timeout
	self.queue_free()
