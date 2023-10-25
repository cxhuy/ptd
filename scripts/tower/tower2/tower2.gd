extends Node2D

var switchDuration: int = 0
var towerId: int = 1
var towerPlacementAllowed: bool = false
var towerPlaced: bool = false

# Tower unique variables
@onready var anim := $PatternSprite
var lightning := preload("res://scenes/tower/tower2/lightning.tscn")

var enemiesInRange
var isEnemyInRange: bool = false


func _ready():
	var base = preload("res://scenes/tower/base.tscn")
	add_child(base.instantiate())
	get_node("Base").connect("body_entered", _on_base_body_entered)
	
	var showOnUIButton = preload("res://scenes/tower/show_on_ui_button.tscn")
	add_child(showOnUIButton.instantiate())


func _process(delta):
	enemiesInRange = $AttackRange.get_overlapping_bodies()
	
	if enemiesInRange.size() > 0:
		isEnemyInRange = true
	else:
		isEnemyInRange = false
		
	if switchDuration == 0:
		anim.play("off")
	else:
		anim.play("on")
		switchDuration -= 1
		
	if !towerPlaced:
		if $Base/BaseArea.get_overlapping_areas().size() > 0:
			self.modulate = Color("ff7664")
			towerPlacementAllowed = false
		else:
			self.modulate = Color("ffffff")
			towerPlacementAllowed = true


func _on_base_body_entered(body):
	if body.is_in_group("Balls"):
		var direction: Vector2 = (self.global_position - body.global_position).normalized()
		body.apply_impulse(direction * -1500)
		switchDuration = 20
		
		if isEnemyInRange:
			var lightningInstance := lightning.instantiate()
			lightningInstance.enemiesSortedByProgress = getEnemiesSortedByProgress(enemiesInRange)
			call_deferred("add_child", lightningInstance)
			
		var tween = create_tween().set_trans(Tween.TRANS_CIRC)
		tween.tween_property(anim, "scale", Vector2(0.3, 0.3), 0.07)	
		await get_tree().create_timer(0.2).timeout
		tween = create_tween().set_trans(Tween.TRANS_CIRC)
		tween.tween_property(anim, "scale", Vector2(0.35, 0.35), 0.28)	
		await get_tree().create_timer(0.2).timeout
		
		
func getEnemiesSortedByProgress(enemiesInRange):
	if enemiesInRange.size() != 0:
		var enemiesInRangeSorted = enemiesInRange
		enemiesInRangeSorted.sort_custom(sortByProgress)
		var allEnemiesSorted = get_tree().get_nodes_in_group("Enemies")
		allEnemiesSorted.sort_custom(sortByProgress)
		var firstIndex: int = allEnemiesSorted.find(enemiesInRangeSorted[0])
		return allEnemiesSorted.slice(firstIndex, \
			firstIndex + Data.towerData[2]["stats"]["targetEnemies"][Data.towerData[2]["level"]])
	else:
		return enemiesInRange
	

func sortByProgress(enemy1, enemy2):
	if enemy1 != null and enemy2 != null:
		return enemy1.get_parent().get_progress() > enemy2.get_parent().get_progress()
	elif enemy1 == null and enemy2 != null:
		return enemy2
	elif enemy2 == null and enemy1 != null:
		return enemy1
	else: 
		return null
