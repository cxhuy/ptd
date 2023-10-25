extends RigidBody2D

var ballSmall := preload("res://scenes/ballSmall.tscn")


#func _on_body_entered(body):
#	shootBallSmall()


#func shootBallSmall():
#	var ballSmallInstance := ballSmall.instantiate()
#	add_child(ballSmallInstance)
#	ballSmallInstance.set_global_position(self.global_position)	
#	var direction = Vector2(cos(deg_to_rad(self.global_rotation_degrees + randf_range(-5, 5))), \
#							sin(deg_to_rad(self.global_rotation_degrees + randf_range(-5, 5))))
#	ballSmallInstance.apply_impulse(direction * -1000)


func _on_visible_on_screen_notifier_2d_screen_exited():
	self.queue_free()


func _on_damage_area_body_entered(body):
	body.damage(Data.ballDamage)
