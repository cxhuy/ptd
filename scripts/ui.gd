extends CanvasLayer

var towerAdd := preload("res://scenes/towerAdd.tscn")

var currentTowerId: int
var towerToDelete


func _ready():
	for i in range(6):
		var towerAddInstance = towerAdd.instantiate()
		var tower = load("res://scenes/tower/tower" + str(i + 1) + "/tower" + str(i + 1) + ".tscn")		
		towerAddInstance.tower = tower		
		towerAddInstance.towerId = i + 1
		$LeftUI/Inventory.add_child(towerAddInstance)
	
	updateTowerData(1)
	updateRightUI()


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
		towerStats += statString + str(towerData["stats"][stat][towerData["level"] - 1]) + "\n"
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
		$LeftUI/TowerData/Buttons/DeleteButton.disabled = true
	else:
		$LeftUI/TowerData/Buttons/DeleteButton.disabled = false		
	self.towerToDelete = towerToDelete
	

func updateRightUI():
	$RightUI/RightUIContainer/Stage.text = "Stage " + str(Data.currentStage)
	$RightUI/RightUIContainer/Wave.text = "Wave " + str(Data.currentWave)
	$RightUI/RightUIContainer/Health/HealthSprite.texture = \
		load("res://sprites/ui/health/" + str(Data.currentHealth) + ".svg")


func _on_upgrade_button_pressed():
	var towerData: Dictionary =  Data.towerData[currentTowerId]
	towerData["quantity"] -= Data.upgradeRequired[towerData["level"]]
	towerData["level"] += 1
	updateTowerData(currentTowerId)


func _on_delete_button_pressed():
	towerToDelete.queue_free()
	towerToDelete = null
	updateTowerData(currentTowerId)	
