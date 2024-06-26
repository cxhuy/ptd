extends Node2D

var ball := preload("res://scenes/ball.tscn")
var enemy := preload("res://scenes/enemy/enemy.tscn")
var rewardItem := preload("res://scenes/rewardItem.tscn")
var enemySpawnFinish: bool = false
var inGame: bool = false
var waveStartButton
var ballSpawnPos: Vector2 = Vector2(616, 770)


func _input(event):
	if Input.is_action_pressed("addBall"):
		var ballInstance = ball.instantiate()
		ballInstance.set_global_position(ballSpawnPos)
		add_child(ballInstance)

	elif Input.is_action_pressed("emptyTank") and $Tank.emptyTank == false and \
	!$Tank/TankCooldownLabel.inCooldown and inGame and Data.currentHealth > 0 and \
	get_tree().get_nodes_in_group("TankBalls").size() > 0:
		$Tank/TankFullLabel.hide()
		$Tank.emptyTank = true
		var tween = create_tween().set_trans(Tween.TRANS_CIRC)
		tween.tween_property($Tank/SendSprite, "modulate:a", 1, 0.4)
		await get_tree().create_timer(2).timeout
		$Tank/TankCooldownLabel.startCooldown()
		$Tank.emptyTank = false
		tween = create_tween().set_trans(Tween.TRANS_CIRC)
		tween.tween_property($Tank/SendSprite, "modulate:a", 0, 0.4)
		await get_tree().create_timer(0.4).timeout

	elif Input.is_action_pressed("restartGame") and \
	get_tree().get_current_scene().get_name() == "Game":
		restartGame()


func loadStage(stageId: int):
	for tower in get_tree().get_nodes_in_group("Towers"):
		Data.towerData[tower.towerId]["quantity"] += 1
		$UI.updateTowerData(tower.towerId)
		tower.queue_free()

	if stageId > 1:
		get_node("Stage" + str(stageId - 1)).queue_free()
	var stage := load("res://scenes/stages/stage" + str(stageId) + ".tscn")
	self.add_child(stage.instantiate())


func _ready():
	loadStage(1)
	waveStartButton = get_node("UI/RightUI/RightUIContainer/WaveStartButton")
	waveStartButton.connect("pressed", _on_wave_start_button_pressed)


func giveReward():
	var unlockedTowers: Array[int] = []
	var lockedTowers: Array[int] = []

	$UI.clearRewards()
	get_node("UI/Rewards").show()
	get_node("UI/Rewards/RewardsSound").play()

	for towerId in Data.towerData:
		if Data.towerData[towerId]["unlocked"]:
			unlockedTowers.append(towerId)
		else:
			lockedTowers.append(towerId)

	if Data.rewards[Data.currentStage][Data.currentWave].has("totalTowersUnlocked"):
		for i in range(Data.rewards[Data.currentStage][Data.currentWave]["totalTowersUnlocked"]):
			var pickRandomIndex: int = randi_range(0, lockedTowers.size() - 1)
			var towerUnlocked: int = lockedTowers.pop_at(pickRandomIndex)
			unlockedTowers.append(towerUnlocked)
			Data.towerData[towerUnlocked]["unlocked"] = true
			$UI.updateTowerData(towerUnlocked)

			var rewardItemInstance = rewardItem.instantiate()
			rewardItemInstance.get_node("RewardSprite").texture = \
				load("res://sprites/towers/tower" + str(towerUnlocked) + "/tower" + str(towerUnlocked) + "_on.svg")
			get_node("UI/Rewards/RewardsContainer/Unlocked").add_child(rewardItemInstance)

	if Data.rewards[Data.currentStage][Data.currentWave].has("towerLimitIncrease"):
		Data.towerLimit += Data.rewards[Data.currentStage][Data.currentWave]["towerLimitIncrease"]

		var rewardItemInstance = rewardItem.instantiate()
		rewardItemInstance.tooltip_text = "Tower limit increased to " + str(Data.towerLimit)
		rewardItemInstance.get_node("RewardSprite").texture = \
			load("res://sprites/ui/specials/tower_limit.png")
		get_node("UI/Rewards/RewardsContainer/Unlocked").add_child(rewardItemInstance)

	if Data.rewards[Data.currentStage][Data.currentWave].has("ballDamageIncrease"):
		Data.ballDamage += Data.rewards[Data.currentStage][Data.currentWave]["ballDamageIncrease"]

		var rewardItemInstance = rewardItem.instantiate()
		rewardItemInstance.tooltip_text = "Ball damage increased to " + str(Data.ballDamage)
		rewardItemInstance.get_node("RewardSprite").texture = \
			load("res://sprites/ui/specials/ball_damage.png")
		get_node("UI/Rewards/RewardsContainer/Unlocked").add_child(rewardItemInstance)

	if Data.rewards[Data.currentStage][Data.currentWave].has("tankLimitIncrease"):
		Data.tankLimit += Data.rewards[Data.currentStage][Data.currentWave]["tankLimitIncrease"]

		var rewardItemInstance = rewardItem.instantiate()
		rewardItemInstance.tooltip_text = "Tank limit increased to " + str(Data.tankLimit)
		rewardItemInstance.get_node("RewardSprite").texture = \
			load("res://sprites/ui/specials/tank_limit.png")
		get_node("UI/Rewards/RewardsContainer/Unlocked").add_child(rewardItemInstance)

	var towerRewardLeft: int = Data.rewards[Data.currentStage][Data.currentWave]["totalTowersReward"]
	var unlockedTowersSize: int = unlockedTowers.size()
	for i in range(unlockedTowersSize):
		var rewardItemInstance = rewardItem.instantiate()
		if i != unlockedTowersSize - 1:
			var pickRandomIndex: int = randi_range(0, unlockedTowers.size() - 1)
			var towerRewarded: int = unlockedTowers.pop_at(pickRandomIndex)
			var rewardAmount: int = randi_range(1, towerRewardLeft - unlockedTowers.size())
			Data.towerData[towerRewarded]["quantity"] += rewardAmount
			$UI.updateTowerData(towerRewarded)
			towerRewardLeft -= rewardAmount

			rewardItemInstance.get_node("RewardSprite").texture = \
				load("res://sprites/towers/tower" + str(towerRewarded) + "/tower" + str(towerRewarded) + "_on.svg")
			rewardItemInstance.get_node("RewardQuantity").text = "x " + str(rewardAmount)
		else:
			Data.towerData[unlockedTowers[0]]["quantity"] += towerRewardLeft
			$UI.updateTowerData(unlockedTowers[0])

			rewardItemInstance.get_node("RewardSprite").texture = \
				load("res://sprites/towers/tower" + str(unlockedTowers[0]) + "/tower" + str(unlockedTowers[0]) + "_on.svg")
			rewardItemInstance.get_node("RewardQuantity").text = "x " + str(towerRewardLeft)
		get_node("UI/Rewards/RewardsContainer/TowerRewards").add_child(rewardItemInstance)


func _process(delta):
	# If wave finished
	if enemySpawnFinish and get_tree().get_nodes_in_group("Enemies").size() == 0:
		if Data.currentStage == 5 and Data.currentWave == 9:
			get_node("UI/GameClear").show()
			get_node("UI/GameClear/GameClearSound").play()
			get_tree().paused = true
		else:
			if Data.currentWave % 3 == 0 or (Data.currentStage == 1 and Data.currentWave == 1):
				giveReward()
			enemySpawnFinish = false
			inGame = false
			get_tree().call_group("Balls", "queue_free")
			waveStartButton.disabled = false

			if Data.currentWave == 9:
				Data.currentStage += 1
				Data.currentWave = 1
				loadStage(Data.currentStage)
			else:
				Data.currentWave += 1

			$UI.updateRightUI()
			$UI.unblockLeftUI()


	# If ball is dropped add a new one
	if inGame and get_tree().get_nodes_in_group("Balls").size() == 0 and \
	Data.currentHealth > 0:
		var ballInstance = ball.instantiate()
		ballInstance.set_global_position(ballSpawnPos)
		add_child(ballInstance)
		$BallAddSound.play()


func _on_wave_start_button_pressed():
	if !inGame:
		startWave(Data.currentWave)
		var ballInstance := ball.instantiate()
		ballInstance.set_global_position(Vector2(616, 583))
		ballInstance.initialBall = true
		add_child(ballInstance)
		$BallAddSound.play()
		inGame = true
		waveStartButton.disabled = true


func startWave(wave):
	$UI.blockLeftUI()
	var wavePattern: Array = Data.waveData[Data.currentStage][Data.currentWave]
	spawnEnemies(wavePattern)


func spawnEnemies(wavePattern):
	for pattern in wavePattern:
		var enemyType: int = pattern[0]
		var enemyId: int = pattern[1]
		var enemyCount: int = pattern[2]
		var spawnDelay: float = pattern[3]
		for i in range(enemyCount):
			var enemyPath: PathFollow2D = PathFollow2D.new()
			enemyPath.set_loop(false)
			var enemyInstance := enemy.instantiate()
			enemyInstance.enemyType = enemyType
			enemyInstance.enemyId = enemyId
			enemyPath.add_child(enemyInstance)
			get_node("Stage" + str(Data.currentStage) + "/EnemyPath").add_child(enemyPath)
			await get_tree().create_timer(spawnDelay).timeout
	enemySpawnFinish = true


func restartGame():
	ResetData.resetData()
	$UI.updateTowerData(1)
