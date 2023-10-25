extends RigidBody2D


func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if local_shape_index == 1:
		call_deferred("send", body, Vector2(960, 15) + \
									Vector2((body.global_position.x - 1630) * 750 / 350, 0))


func send(body, position):
	body.global_position = position
