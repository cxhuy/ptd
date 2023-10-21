extends Path2D

var enemy = preload("res://scenes/enemy/enemy.tscn")


func _on_spawn_timer_timeout():
	var enemyPath: PathFollow2D = PathFollow2D.new()
	var enemyInstance := enemy.instantiate()
	enemyPath.add_child(enemyInstance)
	self.add_child(enemyPath)
