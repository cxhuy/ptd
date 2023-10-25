extends Node2D

var switchDuration: int = 0
var towerId: int = 7
var towerPlacementAllowed: bool = false
var towerPlaced: bool = false

# Tower unique variables
@onready var anim := $PatternSprite
var teleport := preload("res://scenes/tower/tower7/teleport.tscn")


func _ready():
	var base = preload("res://scenes/tower/base.tscn")
	add_child(base.instantiate())
	get_node("Base").connect("body_entered", _on_base_body_entered)
	
	var showOnUIButton = preload("res://scenes/tower/show_on_ui_button.tscn")
	add_child(showOnUIButton.instantiate())


func _process(delta):
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
	if body.is_in_group("Balls") or body.is_in_group("TankBalls"):
		var direction: Vector2 = (self.global_position - body.global_position).normalized()
		body.apply_impulse(direction * -1500)
		switchDuration = 20
		
		var teleportInstance := teleport.instantiate()
		call_deferred("add_child", teleportInstance)		
			
		var tween = create_tween().set_trans(Tween.TRANS_CIRC)
		tween.tween_property(anim, "scale", Vector2(0.3, 0.3), 0.07)	
		await get_tree().create_timer(0.2).timeout
		tween = create_tween().set_trans(Tween.TRANS_CIRC)
		tween.tween_property(anim, "scale", Vector2(0.35, 0.35), 0.28)	
		await get_tree().create_timer(0.2).timeout
