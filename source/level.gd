extends Node2D

@onready var stairs = $StairDisplay
@onready var button = $AlgorithmMenu

func _ready():
	button.shuffle.connect(stairs.shuffle_stairs)
	button.bubble.connect(stairs.bubble_sort)
