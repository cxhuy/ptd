extends CanvasLayer

var towerAdd := preload("res://scenes/towerAdd.tscn")

var currentTowerId: int
var towerToDelete


func _ready():
	for i in range(8):
		var towerAddInstance = towerAdd.instantiate()
		var tower = load("res://scenes/tower/tower" + str(i + 1) + "/tower" + str(i + 1) + ".tscn")		
		towerAddInstance.tower = tower		
		towerAddInstance.towerId = i + 1
		$LeftUI/Inventory.add_child(towerAddInstance)
	
	updateTowerData(1)
	updateRightUI()


func blockLeftUI():
	$LeftUI/BlockClick.show()


func unblockLeftUI():
	$LeftUI/BlockClick.hide()	


func updateTowerData(towerId: int, towerToDelete = null):
	currentTowerId = towerId
	var towerData: Dictionary =  Data.towerData[towerId]
	if towerData["unlocked"]:
		$LeftUI/Inventory.get_child(currentTowerId).get_node("TowerSprite").texture = \
			load("res://sprites/towers/tower" + str(towerId) + "/tower" + str(towerId) + "_ui.png")
	$LeftUI/Inventory.get_child(currentTowerId).get_node("TowerQuantity").text = "x" + str(towerData["quantity"])
	
	$LeftUI/TowerData/TowerName.text = towerData["name"]
	$LeftUI/TowerData/TowerImage/TowerSprite.texture = \
		load("res://sprites/towers/tower" + str(towerId) + "/tower" + str(towerId) + "_on.svg")
	$LeftUI/TowerData/TowerImage/TowerLevel.text = "Lv." + str(towerData["level"])
	$LeftUI/TowerData/TowerDesc.text = towerData["description"]	
	var towerStats: String
	for stat in towerData["stats"]:
		var statString: String
		match stat:
			"damage": statString = "Damage: "
			"targetEnemies": statString = "Target Enemies: "
			"duration": statString = "Duration: "
			"distance": statString = "Distance: "
			"probability": statString = "Probability: "
			"hitsNeeded": statString = "Hits needed: "
		if stat == "probability":
			towerStats += statString + str(towerData["stats"][stat][towerData["level"]]) + "%\n"
		else:
			towerStats += statString + str(towerData["stats"][stat][towerData["level"]]) + "\n"
	$LeftUI/TowerData/TowerStats.text = towerStats
	
	if towerData["level"] < 9:
		$LeftUI/TowerData/Buttons/UpgradeButton.text = \
			"Upgrade\n" + str(towerData["quantity"]) + " / " + str(Data.upgradeRequired[towerData["level"]])
	else:
		$LeftUI/TowerData/Buttons/UpgradeButton.text = "Max Level"
		
	if towerData["level"] < 9 and towerData["quantity"] < Data.upgradeRequired[towerData["level"]] \
	or towerData["level"] == 9:
		$LeftUI/TowerData/Buttons/UpgradeButton.disabled = true
	else:
		$LeftUI/TowerData/Buttons/UpgradeButton.disabled = false
		
	if towerToDelete == null:
		$LeftUI/TowerData/Buttons/RemoveButton.disabled = true
	else:
		$LeftUI/TowerData/Buttons/RemoveButton.disabled = false
	self.towerToDelete = towerToDelete
	

func updateRightUI():
	$RightUI/RightUIContainer/Stage.text = "Stage " + str(Data.currentStage)
	$RightUI/RightUIContainer/Wave.text = "Wave " + str(Data.currentWave)
	$RightUI/RightUIContainer/Health/HealthSprite.texture = \
		load("res://sprites/ui/health/health_" + str(Data.currentHealth) + ".png")


func clearRewards():
	for child in $Rewards/RewardsContainer/Unlocked.get_children():
		child.queue_free()
	for child in $Rewards/RewardsContainer/TowerRewards.get_children():
		child.queue_free()


func _on_upgrade_button_pressed():
	$LeftUI/TowerData/UpgradeSound.play()
	var towerData: Dictionary =  Data.towerData[currentTowerId]
	towerData["quantity"] -= Data.upgradeRequired[towerData["level"]]
	towerData["level"] += 1
	updateTowerData(currentTowerId)


func _on_remove_button_pressed():
	Data.towerData[towerToDelete.towerId]["quantity"] += 1	
	towerToDelete.queue_free()
	towerToDelete = null
	updateTowerData(currentTowerId)	


func _on_rewards_gui_input(event):
	if event is InputEventMouseButton and event.button_mask == 0:
		$Rewards.hide()


func _on_game_over_gui_input(event):
	if event is InputEventMouseButton and event.button_mask == 0:
		get_tree().change_scene_to_file("res://scenes/game.tscn")
		get_tree().reload_current_scene()
		ResetData.resetData()
		updateTowerData(1)
