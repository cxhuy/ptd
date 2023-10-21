extends Area2D


var speed: int = 1000

func _process(delta):
	global_position += Vector2(cos(self.rotation_degrees), sin(self.rotation_degrees)) * speed * delta
