extends Node2D

signal shuffle()
signal bubble()

func _on_button_1_pressed() -> void:
	emit_signal("bubble")

func _on_button_2_pressed() -> void:
	print("Pressed B")

func _on_button_3_pressed() -> void:
	print("Pressed C")

func _on_shuffle_button_pressed() -> void:
	emit_signal("shuffle")
