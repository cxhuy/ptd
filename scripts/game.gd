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
	!$Tank/TankCooldownLabel.inCooldown:
		$Tank/TankFullLabel.hide()
		$Tank.emptyTank = true
		$Tank/SendBottom.show()
		$Tank/SendTop.show()
		await get_tree().create_timer(2).timeout
		$Tank/TankCooldownLabel.startCooldown()
		$Tank.emptyTank = false
		$Tank/SendBottom.hide()
		$Tank/SendTop.hide()		


func loadStage(stageId: int):
	for tower in get_tree().get_nodes_in_group("Towers"):
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
		rewardItemInstance.get_node("RewardSprite").texture = \
			load("res://sprites/ui/specials/tower_limit.png")
		get_node("UI/Rewards/RewardsContainer/Unlocked").add_child(rewardItemInstance)
		
	if Data.rewards[Data.currentStage][Data.currentWave].has("ballDamageIncrease"):
		Data.ballDamage += Data.rewards[Data.currentStage][Data.currentWave]["ballDamageIncrease"]
		
		var rewardItemInstance = rewardItem.instantiate()
		rewardItemInstance.get_node("RewardSprite").texture = \
			load("res://sprites/ui/specials/ball_damage.png")
		get_node("UI/Rewards/RewardsContainer/Unlocked").add_child(rewardItemInstance)
		
	if Data.rewards[Data.currentStage][Data.currentWave].has("tankLimitIncrease"):
		Data.tankLimit += Data.rewards[Data.currentStage][Data.currentWave]["tankLimitIncrease"]
		
		var rewardItemInstance = rewardItem.instantiate()
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
		if Data.currentWave % 3 == 0:
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
		
	
	# If ball is dropped add a new one
	if inGame and get_tree().get_nodes_in_group("Balls").size() == 0:
		var ballInstance = ball.instantiate()
		ballInstance.set_global_position(ballSpawnPos)
		add_child(ballInstance)


func _on_wave_start_button_pressed():
	if !inGame:
		startWave(Data.currentWave)
		var ballInstance := ball.instantiate()
		ballInstance.set_global_position(Vector2(616, 583))
		add_child(ballInstance)
		inGame = true
		waveStartButton.disabled = true


func startWave(wave):
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
