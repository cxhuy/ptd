extends CanvasLayer

var towerAdd := preload("res://scenes/towerAdd.tscn")

var currentTowerId: int


func _ready():
	for i in range(2):
		var towerAddInstance = towerAdd.instantiate()
		var tower = load("res://scenes/tower/tower" + str(i + 1) + "/tower" + str(i + 1) + ".tscn")		
		towerAddInstance.tower = tower		
		towerAddInstance.towerId = i + 1
		$Panel/Inventory.add_child(towerAddInstance)
	
	updateTowerData(1)


func updateTowerData(towerId: int):
	currentTowerId = towerId
	var towerData: Dictionary =  Data.towerData[towerId]
	$Panel/Inventory.get_child(currentTowerId).get_node("TowerQuantity").text = "x" + str(towerData["quantity"])
	
	$Panel/TowerData/TowerName.text = towerData["name"]
	$Panel/TowerData/TowerImage/TowerSprite.texture = \
		load("res://sprites/towers/tower" + str(towerId) + "/tower" + str(towerId) + "_on.svg")
	$Panel/TowerData/TowerImage/TowerLevel.text = "Lv." + str(towerData["level"])
	$Panel/TowerData/TowerDesc.text = towerData["description"]	
	var towerStats: String
	for stat in towerData["stats"]:
		var statString: String
		match stat:
			"damage": statString = "Damage: "
			"targetEnemies": statString = "Target Enemies: "
		towerStats += statString + str(towerData["stats"][stat][towerData["level"] - 1]) + "\n"
	$Panel/TowerData/TowerStats.text = towerStats
	
	if towerData["level"] < 9:
		$Panel/TowerData/Buttons/UpgradeButton.text = \
			"Upgrade\n" + str(towerData["quantity"]) + " / " + str(Data.upgradeRequired[towerData["level"]])
	else:
		$Panel/TowerData/Buttons/UpgradeButton.text = "Max Level"
		
	if towerData["level"] < 9 and towerData["quantity"] < Data.upgradeRequired[towerData["level"]] \
	or towerData["level"] == 9:
		$Panel/TowerData/Buttons/UpgradeButton.disabled = true
	else:
		$Panel/TowerData/Buttons/UpgradeButton.disabled = false


func _on_upgrade_button_pressed():
	var towerData: Dictionary =  Data.towerData[currentTowerId]
	towerData["quantity"] -= Data.upgradeRequired[towerData["level"]]
	towerData["level"] += 1
	updateTowerData(currentTowerId)
