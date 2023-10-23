extends Node2D

@onready var anim := $PatternSprite
#var explosion := preload("res://scenes/tower/tower1/explosion.tscn")

var switchDuration: int = 0
var enemiesInRange
var isEnemyInRange: bool = false


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


func _on_base_body_entered(body):
	if body.is_in_group("Balls"):
		var direction: Vector2 = (self.global_position - body.global_position).normalized()
		body.apply_impulse(direction * -1500)
		switchDuration = 20
#		var explosionInstance := explosion.instantiate()
#		call_deferred("add_child", explosionInstance)			
		var tween = create_tween().set_trans(Tween.TRANS_CIRC)
		tween.tween_property(anim, "scale", Vector2(0.3, 0.3), 0.07)	
		await get_tree().create_timer(0.2).timeout
		tween = create_tween().set_trans(Tween.TRANS_CIRC)
		tween.tween_property(anim, "scale", Vector2(0.35, 0.35), 0.28)	
		await get_tree().create_timer(0.2).timeout
		
		
func getEnemiesSortedByProgress(enemiesInRange):
	if enemiesInRange.size() >= 2:
		var enemiesSortedByProgress = enemiesInRange
		enemiesSortedByProgress.sort_custom(sortByProgress)
		return enemiesSortedByProgress
	elif enemiesInRange.size() == 1:
		return enemiesInRange[0]
	else:
		return null
	

func sortByProgress(enemy1, enemy2):
	return enemy1.get_parent().get_progress() < enemy2.get_parent().get_progress()
	
