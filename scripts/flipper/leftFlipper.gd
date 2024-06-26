extends CharacterBody2D

var isPressed: bool = false
var startAngle: int = 210
var maxAngle: int = 120


func _physics_process(delta):
	if Input.is_action_pressed("leftFlip"):
		self.rotation_degrees = max(maxAngle, self.rotation_degrees - 5)

	else:
		self.rotation_degrees = min(startAngle, self.rotation_degrees + 10)
