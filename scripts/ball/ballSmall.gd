extends RigidBody2D


func _on_timer_timeout():
	self.queue_free()
