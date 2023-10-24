extends Area2D

@onready var lightningEffect := $LightningEffect

var enemiesSortedByProgress


func _ready():	
	self.global_position = get_parent().global_position
	
	lightningEffect.add_point(Vector2(0, 0))
	
	for i in range(enemiesSortedByProgress.size()):
		if enemiesSortedByProgress[i] == null: 
			continue
		var currPointPos: Vector2 = enemiesSortedByProgress[i].global_position - self.global_position
		lightningEffect.add_point(currPointPos)	
		if i != enemiesSortedByProgress.size() - 1:
			var nextPointPos: Vector2 = enemiesSortedByProgress[i + 1].global_position - self.global_position
			var midPointPos: Vector2 = (currPointPos + nextPointPos) / 2
			lightningEffect.add_point(midPointPos + Vector2(randi_range(-50, 50), randi_range(-50, 50)))
		
		enemiesSortedByProgress[i].damage(Data.towerData[2]["stats"]["damage"])
		
	var tween = create_tween().set_trans(Tween.TRANS_CIRC)
	tween.tween_property(self, "modulate:a", 0, 1)	
	await get_tree().create_timer(1).timeout
	self.queue_free()

