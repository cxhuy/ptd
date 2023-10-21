extends Path2D

var enemy := preload("res://scenes/enemy/enemy.tscn")
var currentWave: int = 1
var enemySpawnFinish: bool = false
var inGame: bool = false

#func _on_spawn_timer_timeout():
#	var enemyPath: PathFollow2D = PathFollow2D.new()
#	enemyPath.set_loop(false)
#	var enemyInstance := enemy.instantiate()
#	enemyPath.add_child(enemyInstance)
#	self.add_child(enemyPath)

func _process(delta):
	if enemySpawnFinish and get_tree().get_nodes_in_group("Enemies").size() == 0:
		print("done")
		enemySpawnFinish = false
		inGame = false
		currentWave += 1


func _on_wave_start_button_pressed():
	if !inGame:
		startWave(currentWave)
		inGame = true


func startWave(wave):
	var wavePattern: Array[Array]
	match wave:
		1: 
			wavePattern = [[0, 5, 1]]
		2: 
			wavePattern = [[0, 10, 1]]
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
	enemySpawnFinish = true
