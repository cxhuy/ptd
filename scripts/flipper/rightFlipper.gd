extends CharacterBody2D

var isPressed: bool = false
var startAngle: int = -30
var maxAngle: int = 60


func _physics_process(delta):
	if Input.is_action_pressed("rightFlip"):
		self.rotation_degrees = min(maxAngle, self.rotation_degrees + 5)
		
	else:
		self.rotation_degrees = max(startAngle, self.rotation_degrees - 10)
