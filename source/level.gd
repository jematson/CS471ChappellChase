extends Node2D

# Level Starting Conditions
var level_number = 1
#var num_stairs = 15
var stair_start = []
var algorithm_options = []

var levels = {
	1:
	[
		[
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
		],
		[
			"BubbleSortButton",
			"MergeSortButton",
			"InsertionSortButton",
		],
		15,
	],
	2:
	[
		[
			1,
			2,
			13,
			4,
			14,
			5,
			6,
			7,
			8,
			9,
			3,
			10,
			11,
			12,
			15,
		],
		[
			"BubbleSortButton",
			"InsertionSortButton",
			"SelectionSortButton",
		],
		20,
	]
}

@onready var executor = $AlgorithmExecuter
@onready var button = $AlgorithmMenu
@onready var label = $LevelLabel


func _ready():
	label.text = "Level " + str(level_number)
	stair_start = levels[1][0]
	algorithm_options = levels[1][1]
	executor.sorted.connect(self.new_level)
	button.shuffle.connect(executor.shuffle_stairs)
	button.bubble.connect(executor.bubble_sort)
	button.quick.connect(executor.call_quicksort)
	button.insert.connect(executor.call_insertionsort)
	button.selection.connect(executor.call_selectionsort)
	button.merge.connect(executor.call_merge_sort)

	button.button_options(algorithm_options)
	executor.initialize_stairs(levels[level_number][2], stair_start)


func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func new_level():
	level_number += 1
	if level_number > 2:
		level_number = 1
	print("New level: ", level_number)
	label.text = "Level " + str(level_number)
	executor.reset()
	stair_start = levels[level_number][0]
	algorithm_options = levels[level_number][1]
	button.button_options(algorithm_options)
	executor.initialize_stairs(levels[level_number][2], stair_start)
