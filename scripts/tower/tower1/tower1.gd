extends Node2D

@onready var anim := $PatternSprite
var explosion := preload("res://scenes/tower/tower1/explosion.tscn")

var switchDuration: int = 0


func _process(delta):
	if switchDuration == 0:
		anim.play("off")
	else:
		anim.play("on")
		switchDuration -= 1


func _on_base_body_entered(body):
	if body.is_in_group("Balls"):
		var direction: Vector2 = (self.global_position - body.global_position).normalized()
		body.apply_impulse(direction * -1500)
		switchDuration = 20
		var explosionInstance := explosion.instantiate()
		add_child(explosionInstance)
		explosionInstance.set_global_position(self.global_position)
