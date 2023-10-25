extends RigidBody2D


func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if local_shape_index == 1:
		call_deferred("send", body, Vector2(960, 15) + \
									Vector2((body.global_position.x - 1630) * 750 / 350, 0))


func send(body: RigidBody2D, position):
	var newPhysicsMaterial: PhysicsMaterial = PhysicsMaterial.new()
	newPhysicsMaterial.friction = 0.3
	newPhysicsMaterial.bounce = 0.1
	body.physics_material_override = newPhysicsMaterial
	body.sent = true
	body.global_position = position
