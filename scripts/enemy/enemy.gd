extends CharacterBody2D

var ball := preload("res://scenes/tankBall.tscn")
var enemyId: int = 0
var enemy: Dictionary = {
	0: {"speed": 400, "health": 10},
}
var speed: int
var health: int


func _ready():
	self.speed = enemy[enemyId]["speed"]
	self.health = enemy[enemyId]["health"]


func _process(delta):	
	get_parent().set_progress(get_parent().get_progress() + speed * delta)	
	self.global_rotation_degrees = 0
	
	if get_parent().get_progress_ratio() == 1:
		Data.currentHealth -= 1
		get_node("../../../../UI").updateRightUI()
		if Data.currentHealth == 0:
			get_tree().paused = true
		self.queue_free()


func damage(damageAmount: int):
	self.health -= damageAmount
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
