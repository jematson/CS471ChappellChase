extends Node2D

#var num_stairs = 15
var stair_start = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
var algorithm_options = [
	"BubbleSortButton",
	"MergeSortButton",
	"InsertionSortButton",
	"QuickSortButton",
	"SelectionSortButton",
	"BogoSortButton",
]

@onready var executor = $AlgorithmExecuter
@onready var button = $AlgorithmMenu
@onready var label = $LevelLabel
@onready var thedisplay = executor.display


func _ready():
	# Initialize large random list for level 2

	label.text = "Practice Mode"
	executor.algorithm_done.connect(thedisplay.check_display)
	#thedisplay.display_sorted.connect(self.new_level)
	button.shuffle.connect(executor.shuffle_stairs)
	button.bubble.connect(executor.bubble_sort)
	button.quick.connect(executor.call_quicksort)
	button.insert.connect(executor.call_insertionsort)
	button.selection.connect(executor.call_selectionsort)
	button.merge.connect(executor.call_merge_sort)
	button.bogo.connect(executor.call_bogo_sort)

	button.button_options(algorithm_options)
	executor.initialize_stairs(stair_start.size(), stair_start)


func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_shuffle_button_pressed() -> void:
	executor.shuffle_stairs()


func _on_large_button_pressed() -> void:
	if stair_start.size() != 50:
		stair_start = []
		for i in range(1, 51):
			stair_start.append(i)
		executor.reset()
		executor.initialize_stairs(stair_start.size(), stair_start)


func _on_small_button_pressed() -> void:
	if stair_start.size() != 15:
		stair_start = []
		for i in range(1, 16):
			stair_start.append(i)
		executor.reset()
		executor.initialize_stairs(stair_start.size(), stair_start)
