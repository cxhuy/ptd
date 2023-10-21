extends Node2D

var ball = preload("res://scenes/ball.tscn")


func _input(event):
	if Input.is_action_pressed("addBall"):
		var ballInstance = ball.instantiate()
		ballInstance.set_global_position(Vector2(616, 583))
		add_child(ballInstance)
