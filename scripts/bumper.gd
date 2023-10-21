extends RigidBody2D


func _on_body_entered(body):
	if body.name == "Ball":
		var direction = position - body.position
		direction = direction.normalized()
		var impulse = direction * -1500
		body.apply_impulse(impulse)
