extends Node2D


func _on_game_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")
	

func _on_help_button_pressed():
	get_tree().change_scene_to_file("res://scenes/help.tscn")
