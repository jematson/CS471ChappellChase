extends Node2D

# Level Starting Conditions
var num_stairs = 15

var stair_start = [
	1,
	3,
	2,
	4,
	5,
	7,
	6,
	8,
	9,
	11,
	13,
	10,
	12,
	15,
	14,
]
var algorithm_options = [
	"BubbleSortButton",
	"QuickSortButton",
	"InsertionSortButton",
]

@onready var executor = $AlgorithmExecuter
@onready var button = $AlgorithmMenu



@onready var executor = $AlgorithmExecuter
@onready var button = $AlgorithmMenu


func _ready():
	button.shuffle.connect(executor.shuffle_stairs)
	button.bubble.connect(executor.bubble_sort)
	button.quick.connect(executor.call_quicksort)
	button.insert.connect(executor.call_insertionsort)
	button.selection.connect(executor.call_selectionsort)


	button.button_options(algorithm_options)
	executor.initialize_stairs(num_stairs, stair_start)


func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
