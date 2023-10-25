extends Area2D

var speed: int = 2000


func _ready():
	self.global_position = get_parent().global_position
	self.global_rotation_degrees = get_parent().global_rotation_degrees


func _process(delta):
	self.global_position += \
		Vector2(cos(deg_to_rad(self.global_rotation_degrees)), \
				sin(deg_to_rad(self.global_rotation_degrees))) * speed * delta


func _on_body_entered(body):
	body.damage(Data.towerData[4]["stats"]["damage"][Data.towerData[4]["level"]])


func _on_visible_on_screen_notifier_2d_screen_exited():
	self.queue_free()
