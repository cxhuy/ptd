extends Area2D

var speed: int = 2000
var damageIncrease: int = 0


func _ready():
	self.global_position = get_parent().global_position
	self.global_rotation_degrees = get_parent().global_rotation_degrees


func _process(delta):
	damageIncrease += 1
	self.global_position += \
		Vector2(cos(deg_to_rad(self.global_rotation_degrees)), \
				sin(deg_to_rad(self.global_rotation_degrees))) * speed * delta


func _on_body_entered(body):
	var damage: int = Data.towerData[4]["stats"]["damage"][Data.towerData[4]["level"]]
	var maxDamage: int = Data.towerData[4]["stats"]["damage"][Data.towerData[4]["level"]] * 2
	var increasedDamage: int = min(damage * (1 + 0.05 * damageIncrease), maxDamage)
	body.damage(increasedDamage)


func _on_visible_on_screen_notifier_2d_screen_exited():
	self.queue_free()
