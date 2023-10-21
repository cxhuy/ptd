extends Node2D


func _process(delta):
	var enemiesInRange = $AttackRange.get_overlapping_bodies()
	if enemiesInRange.size() > 0:
		look_at(getFirstEnemy(enemiesInRange).global_position)
	get_node("SwitchSprite").global_rotation = 0


func getFirstEnemy(enemiesInRange):
	var firstEnemy = enemiesInRange[0]

	for enemy in enemiesInRange:
		if enemy.get_parent().get_index() < firstEnemy.get_parent().get_index():
			firstEnemy = enemy

	return firstEnemy
	
	
#func getNearestEnemy(enemiesInRange):
#	var nearestEnemy = enemiesInRange[0]
#	var nearestDist: float = self.global_position.distance_squared_to(nearestEnemy.global_position)
#
#	for enemy in enemiesInRange:
#		var enemyDist = self.global_position.distance_squared_to(enemy.global_position)
#		if enemyDist < nearestDist:
#			nearestEnemy = enemy
#			nearestDist = enemyDist
#
#	return nearestEnemy
	
