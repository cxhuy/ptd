extends RigidBody2D

var ballSmall := preload("res://scenes/ballSmall.tscn")


func _on_body_entered(body):
	var ballSmallInstance := ballSmall.instantiate()
	add_child(ballSmallInstance)
	ballSmallInstance.set_global_position(self.global_position)	
	
