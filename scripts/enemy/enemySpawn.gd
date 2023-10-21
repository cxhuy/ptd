extends Path2D

var enemy := preload("res://scenes/enemy/enemy.tscn")


#func _on_spawn_timer_timeout():
#	var enemyPath: PathFollow2D = PathFollow2D.new()
#	enemyPath.set_loop(false)
#	var enemyInstance := enemy.instantiate()
#	enemyPath.add_child(enemyInstance)
#	self.add_child(enemyPath)


func _ready():
	startWave(1)


func startWave(wave):
	match wave:
		1: 
			var wavePattern: Array[Array] = [[0, 10, 1]]
			spawnEnemies(wavePattern)


func spawnEnemies(wavePattern):
	for pattern in wavePattern:
		var enemyId: int = pattern[0]
		var enemyCount: int = pattern[1]
		var spawnDelay: float = pattern[2]
		for i in range(enemyCount):
			var enemyPath: PathFollow2D = PathFollow2D.new()
			enemyPath.set_loop(false)
			var enemyInstance := enemy.instantiate()
			enemyInstance.enemyId = enemyId
			enemyPath.add_child(enemyInstance)
			self.add_child(enemyPath)
			await get_tree().create_timer(spawnDelay).timeout
