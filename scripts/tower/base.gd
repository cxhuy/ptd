extends RigidBody2D

@onready var anim = get_node("../SwitchSprite")

var bullet := preload("res://scenes/tower/bullet.tscn")
var switchDuration: int = 0


func _process(delta):
	if switchDuration == 0:
		anim.play("default")
	else:
		anim.play("collision")
		switchDuration -= 1


func _on_body_entered(body):
	if body.is_in_group("Balls"):
		var direction: Vector2 = (self.global_position - body.global_position).normalized()
		body.apply_impulse(direction * -1500)
		switchDuration = 5
		if get_parent().isEnemyInRange:
			var bulletInstance = bullet.instantiate()
			bulletInstance.set_global_position(get_parent().global_position)
			bulletInstance.set_global_rotation_degrees(get_parent().global_rotation_degrees)
			get_tree().get_root().get_node("Game").get_node("Projectiles").add_child(bulletInstance)
