extends RigidBody2D

var emptyTank: bool = false


func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if local_shape_index == 1 and emptyTank:
		call_deferred("send", body, Vector2(960, 0) + \
									Vector2((body.global_position.x - 1630) * 750 / 350, 0))


func send(body: RigidBody2D, position):
	var newPhysicsMaterial: PhysicsMaterial = PhysicsMaterial.new()
	newPhysicsMaterial.friction = 0.3
	newPhysicsMaterial.bounce = 0.1
	body.physics_material_override = newPhysicsMaterial
	body.sent = true
	body.apply_impulse(body.velocity)
	body.get_node("Duration").start(10)
	body.global_position = position
