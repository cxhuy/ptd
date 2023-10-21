extends RigidBody2D

@onready var anim = get_node("../SwitchSprite")

var switchDuration: int = 0


func _process(delta):
	if switchDuration == 0:
		anim.play("default")
	else:
		anim.play("collision")
		switchDuration -= 1


func _on_body_entered(body):
	if body.name == "Ball":
		var direction: Vector2 = (position - body.position).normalized()
		body.apply_impulse(direction * 1500)
		switchDuration = 5
