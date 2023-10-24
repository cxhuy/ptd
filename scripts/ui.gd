extends CanvasLayer

var towerAdd := preload("res://scenes/towerAdd.tscn")


func _ready():
	for i in range(2):
		var towerAddInstance = towerAdd.instantiate()
		var tower = load("res://scenes/tower/tower" + str(i + 1) + "/tower" + str(i + 1) + ".tscn")		
		towerAddInstance.tower = tower		
		towerAddInstance.towerId = i + 1
		$Panel/Inventory.add_child(towerAddInstance)


func updateTowerData(towerId: int):
	var towerData: Dictionary =  Data.towerData[towerId]
	$Panel/TowerData/TowerName.text = towerData["name"]
	$Panel/TowerData/TowerImage/TowerSprite.texture = \
		load("res://sprites/towers/tower" + str(towerId) + "/tower" + str(towerId) + "_on.svg")
	$Panel/TowerData/TowerDesc.text = towerData["description"]	
	var towerStats: String
	for stat in towerData["stats"]:
		var statString: String
		match stat:
			"damage": statString = "Damage: "
			"targetEnemies": statString = "Target Enemies: "
		towerStats += statString + str(towerData["stats"][stat]) + "\n"
	$Panel/TowerData/TowerStats.text = towerStats
	$Panel/TowerData/Buttons/UpgradeButton.text = \
		"Upgrade\n" + str(towerData["quantity"]) + " / " + str(Data.upgradeRequired[towerData["level"]])
