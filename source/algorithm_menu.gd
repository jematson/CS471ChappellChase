extends Node2D

signal shuffle
signal bubble
signal quick
signal insert
signal selection


func _on_button_1_pressed() -> void:
	emit_signal("bubble")


func _on_button_2_pressed() -> void:
	emit_signal("quick")


func _on_button_3_pressed() -> void:
	print("Button 3 pressed")


func _on_shuffle_button_pressed() -> void:
	emit_signal("shuffle")


func _on_inssort_button_pressed() -> void:
	emit_signal("insert")


func _on_selection_sort_button_pressed() -> void:
	emit_signal("selection")
