extends RigidBody2D


func _on_body_entered(body):
	if body.is_in_group("Balls") or body.is_in_group("TankBalls"):
		$BounceSound.play()
