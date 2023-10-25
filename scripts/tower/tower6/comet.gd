extends Area2D


func _on_body_entered(body):
	body.damage(Data.towerData[6]["stats"]["damage"][Data.towerData[6]["level"]])
