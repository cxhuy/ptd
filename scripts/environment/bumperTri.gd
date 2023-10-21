extends RigidBody2D


func _on_body_entered(body):
	if body.is_in_group("Balls"):
		var direction: Vector2 = (position - body.position).normalized()
		body.apply_impulse(direction * 1500)
