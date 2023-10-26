extends Node2D


var helpIndex: int = 1


func _on_next_button_pressed():
	helpIndex += 1
	if helpIndex > 4:
		get_tree().change_scene_to_file("res://scenes/main_screen.tscn")
	$HelpImage.texture = \
		load("res://sprites/ui/help/help" + str(helpIndex) + ".png")
