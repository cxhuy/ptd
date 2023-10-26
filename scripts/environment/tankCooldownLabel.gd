extends Label

var timeLeft: int
var inCooldown: bool = false


func startCooldown():
	self.show()
	timeLeft = 30
	inCooldown = true
	
	while timeLeft > 0:
		self.text = str(timeLeft)
		if get_parent().get_parent().inGame:
			timeLeft -= 1
		await get_tree().create_timer(1).timeout
	
	for tankball in get_tree().get_nodes_in_group("TankBalls"):
		tankball.queue_free()
	self.hide()
	inCooldown = false
