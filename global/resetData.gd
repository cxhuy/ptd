extends Node

var currentStage: int
var currentWave: int
var currentHealth: int

var towerLimit: int
var ballDamage: int
var tankLimit: int

var towerData: Dictionary


func _ready():
	currentStage = Data.currentStage
	currentWave = Data.currentWave
	currentHealth = Data.currentHealth
	
	towerLimit = Data.towerLimit
	ballDamage = Data.ballDamage
	tankLimit = Data.tankLimit
	
	towerData = Data.towerData.duplicate(true)


func resetData():
	Data.currentStage = currentStage
	Data.currentWave = currentWave
	Data.currentHealth = currentHealth
	
	Data.towerLimit = towerLimit
	Data.ballDamage = ballDamage
	Data.tankLimit = tankLimit
	
	Data.towerData = towerData
