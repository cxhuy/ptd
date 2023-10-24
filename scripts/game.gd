extends Node2D

var ball = preload("res://scenes/ball.tscn")
var enemy := preload("res://scenes/enemy/enemy.tscn")
var currentStage: int = 1
var currentWave: int = 1
var enemySpawnFinish: bool = false
var inGame: bool = false
var waveStartButton


func _input(event):
	if Input.is_action_pressed("addBall"):
		var ballInstance = ball.instantiate()
		ballInstance.set_global_position(Vector2(616, 583))
		add_child(ballInstance)


func _ready():
	waveStartButton = get_node("UI/RightUI/RightUIContainer/WaveStartButton")
	waveStartButton.connect("pressed", _on_wave_start_button_pressed)


func _process(delta):
	if enemySpawnFinish and get_tree().get_nodes_in_group("Enemies").size() == 0:
		enemySpawnFinish = false
		inGame = false
		get_tree().call_group("Balls", "queue_free")
		currentWave += 1
		waveStartButton.disabled = false
	
	if inGame and get_tree().get_nodes_in_group("Balls").size() == 0:
		var ballInstance = ball.instantiate()
		ballInstance.set_global_position(Vector2(616, 583))
		add_child(ballInstance)


func _on_wave_start_button_pressed():
	if !inGame:
		startWave(currentWave)
		var ballInstance := ball.instantiate()
		ballInstance.set_global_position(Vector2(616, 583))
		add_child(ballInstance)
		inGame = true
		waveStartButton.disabled = true


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
			get_node("Stage" + str(currentStage) + "/EnemyPath").add_child(enemyPath)
			await get_tree().create_timer(spawnDelay).timeout
	enemySpawnFinish = true

