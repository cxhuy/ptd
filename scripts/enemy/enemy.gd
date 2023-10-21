extends CharacterBody2D

var enemyId: int = 0
var enemy: Dictionary = {
	0: {"speed": 40, "health": 10},
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
		self.queue_free()


func damage(damageAmount: int):
	self.health -= damageAmount
	if self.health <= 0:
		self.queue_free()
