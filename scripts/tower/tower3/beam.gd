extends Area2D


func _ready():
	var tween = create_tween().set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "rotation_degrees", self.rotation_degrees + 60, 0.5)
	var tween2 = create_tween().set_ease(Tween.EASE_OUT)
	tween2.tween_property(self, "scale", Vector2(2, 2), 0.5)
	var tween3 = create_tween().set_ease(Tween.EASE_OUT)
	tween2.tween_property(self, "modulate:a", 0, 0.5)
	await get_tree().create_timer(0.5).timeout
	self.queue_free()


func _on_body_entered(body):
	body.damage(Data.towerData[3]["stats"]["damage"][Data.towerData[3]["level"]])
