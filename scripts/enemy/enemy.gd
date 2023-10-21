extends CharacterBody2D

var speed: int = 100


func _process(delta):
	get_parent().set_progress(get_parent().get_progress() + speed * delta)	
	self.global_rotation_degrees = 0
	if get_parent().get_progress_ratio() == 1:
		self.queue_free()
