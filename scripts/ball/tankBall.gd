extends RigidBody2D

var velocity: Vector2 = Vector2(cos(randi_range(0, 360)), sin(randi_range(0, 360))) * 1000

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)

	if collision:
		velocity = velocity.bounce(collision.get_normal()) 

func _on_visible_on_screen_notifier_2d_screen_exited():
	self.queue_free()