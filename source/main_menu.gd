extends Control


func _on_game_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level.tscn")


func _on_practice_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/practice_level.tscn")
