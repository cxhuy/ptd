extends Area2D

@onready var lightningEffect := $LightningEffect

var enemiesSortedByProgress


func _ready():	
	self.global_position = get_parent().global_position
	lightningEffect.add_point(Vector2(0, 0))
	
	for enemy in enemiesSortedByProgress:
		lightningEffect.add_point(enemy.global_position - self.global_position)
