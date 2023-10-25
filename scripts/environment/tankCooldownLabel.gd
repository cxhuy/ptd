extends Label

var timeLeft: int
var inCooldown: bool = false


func startCooldown():
	self.show()
	timeLeft = 30
	inCooldown = true
	
	for i in range(30):
		self.text = str(timeLeft)
		timeLeft -= 1
		await get_tree().create_timer(1).timeout
	
	self.hide()
	inCooldown = false
	
	
