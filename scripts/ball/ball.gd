extends RigidBody2D

var ballSmall := preload("res://scenes/ballSmall.tscn")
var initialBall: bool = false


func _ready():
	if !initialBall:
		self.freeze = true
		$BallSprite.hide()
		$Delay.show()
		for i in range(3):
			$Delay.text = str(3 - i)
			await get_tree().create_timer(1).timeout
		self.freeze = false
		$BallSprite.show()
		$Delay.hide()

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
