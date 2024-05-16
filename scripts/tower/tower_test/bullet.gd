extends Area2D


var speed: int = 2000
var damage: int = 10

func _process(delta):
	global_position += \
	Vector2(cos(deg_to_rad(self.global_rotation_degrees)), \
			sin(deg_to_rad(self.global_rotation_degrees))) * speed * delta


func _on_body_entered(body):
	body.damage(damage)
