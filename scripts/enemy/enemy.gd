extends CharacterBody2D

var ball := preload("res://scenes/tankBall.tscn")
var enemyType: int
var enemyId: int
var speed: int
var health: int

# Debuffs
var poisonDuration: int = -1


func _ready():
	self.speed = Data.enemyData[enemyType][enemyId]["speed"]
	self.health = Data.enemyData[enemyType][enemyId]["health"]
	$EnemySprite.texture = \
		load("res://sprites/enemy/Enemy_" + str(enemyType) + "_" + str(enemyId) + ".png")


func _process(delta):	
	get_parent().set_progress(get_parent().get_progress() + speed * delta)	
	self.global_rotation_degrees = 0
	
	if get_parent().get_progress_ratio() == 1:
		Data.currentHealth -= 1
		get_node("../../../../UI").updateRightUI()
		if Data.currentHealth == 0:
			get_node("../../../../UI/GameOver").show()
		self.queue_free()


func _physics_process(delta):
	# Poison Damage
	if poisonDuration >= 0:
		if poisonDuration % 240 == 0: # Every 1 second
			self.damage(Data.towerData[5]["stats"]["damage"][Data.towerData[5]["level"]])
		poisonDuration -= 1


func damage(damageAmount: int):
	self.health -= damageAmount
	var healthPercentage: float = float(self.health) / Data.enemyData[enemyType][enemyId]["health"]
	$HealthBar.size.x = 40 * healthPercentage
	$HealthBar.set_color(Color((1 - healthPercentage), healthPercentage, 0, 1))
	if self.health <= 0:
		var randomNumber = randf_range(0, 1)
		if randomNumber <= 0.05 and \
		get_tree().get_nodes_in_group("TankBalls").size() < Data.tankLimit and \
		!get_node("../../../..//Tank/TankCooldownLabel").inCooldown: 
			if get_tree().get_nodes_in_group("TankBalls").size() == Data.tankLimit - 1:
				get_node("../../../..//Tank/TankFullLabel").show()
			var ballInstance = ball.instantiate()
			ballInstance.global_position = Vector2(1600, 450)
			get_tree().get_root().get_node("Game").call_deferred("add_child", ballInstance)
		self.queue_free()
