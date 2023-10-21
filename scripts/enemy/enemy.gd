extends CharacterBody2D

var speed: int = 100


func _process(delta):
	get_parent().set_progress(get_parent().progress + speed * delta)	
	self.global_rotation_degrees = 0
