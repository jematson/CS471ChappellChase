extends Node2D

signal shuffle
signal bubble
signal quick
signal insert
signal selection
signal merge
signal bogo

@onready var button_box = $HBoxContainer


func button_options(algorithm_options):
	for child in button_box.get_children():
		if child.name in algorithm_options:
			child.show()
		else:
			child.hide()


func _on_button_1_pressed() -> void:
	emit_signal("bubble")


func _on_button_2_pressed() -> void:
	emit_signal("quick")


func _on_shuffle_button_pressed() -> void:
	emit_signal("shuffle")


func _on_inssort_button_pressed() -> void:
	emit_signal("insert")


func _on_selection_sort_button_pressed() -> void:
	emit_signal("selection")


func _on_mergesort_button_pressed() -> void:
	emit_signal("merge")


func _on_bogo_sort_button_pressed() -> void:
	print("Bogo signal")
	emit_signal("bogo")
