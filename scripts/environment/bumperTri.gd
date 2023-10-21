extends RigidBody2D


#func _on_body_entered(body):
#	if body.is_in_group("Balls"):
#		var direction: Vector2 = (self.global_position - body.global_position).normalized()
#		print(direction)
#		body.apply_impulse(Vector2(direction.x * -500, direction.y * -1000))
