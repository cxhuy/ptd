extends Node2D

var switchDuration: int = 0
var towerId: int = 6
var towerPlacementAllowed: bool = false
var towerPlaced: bool = false

# Tower unique variables
var comet := preload("res://scenes/tower/tower6/comet.tscn")


func _ready():
	var base = preload("res://scenes/tower/base.tscn")
	add_child(base.instantiate())
	get_node("Base").connect("body_entered", _on_base_body_entered)
	
	var showOnUIButton = preload("res://scenes/tower/show_on_ui_button.tscn")
	add_child(showOnUIButton.instantiate())
	
	var cometInstance := comet.instantiate()
	cometInstance.position = Vector2(0, 200)
	call_deferred("add_child", cometInstance)	


func _process(delta):		
	if !towerPlaced:
		if $Base/BaseArea.get_overlapping_areas().size() > 0:
			self.modulate = Color("ff7664")
			towerPlacementAllowed = false
		else:
			self.modulate = Color("ffffff")
			towerPlacementAllowed = true


func _physics_process(delta):
	if towerPlaced:
		self.global_rotation_degrees += 1
		$PatternSprite.global_rotation_degrees = 0


func _on_base_body_entered(body):
	if body.is_in_group("Balls") or body.is_in_group("TankBalls"):
		var direction: Vector2 = (self.global_position - body.global_position).normalized()
		body.apply_impulse(direction * -1500)
		switchDuration = 20	
			
		var tween = create_tween().set_trans(Tween.TRANS_CIRC)
		tween.tween_property($PatternSprite, "scale", Vector2(0.3, 0.3), 0.07)	
		await get_tree().create_timer(0.2).timeout
		tween = create_tween().set_trans(Tween.TRANS_CIRC)
		tween.tween_property($PatternSprite, "scale", Vector2(0.35, 0.35), 0.28)	
		await get_tree().create_timer(0.2).timeout
