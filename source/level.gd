extends Node2D

# Level Starting Conditions
var level_number = 1
#var num_stairs = 15
var stair_start = []
var algorithm_options = []
var victory_screen: AnimatedSprite2D

var levels = {
	1:
	[
		[
			1,
			2,
			14,
			4,
			12,
			6,
			7,
			8,
			9,
			10,
			11,
			3,
			13,
			5,
			15,
		],
		[  # Correct: InsertionSort
			"BubbleSortButton",
			"MergeSortButton",
			"InsertionSortButton",
		],
	],
	2:
	[
		[],
		[  # Correct: QuickSort
			"BogoSortButton",
			"QuickSortButton",
			"SelectionSortButton",
		],
	],
	3:
	[
		[
			2,
			1,
			3,
			4,
			5,
			6,
			7,
			9,
			8,
			10,
		],
		[  # Correct: BubbleSort
			"BogoSortButton",
			"MergeSortButton",
			"BubbleSortButton",
		],
	]
}

@onready var executor = $AlgorithmExecuter
@onready var button = $AlgorithmMenu
@onready var label = $LevelLabel
@onready var thedisplay = executor.display


func _ready():
	victory_screen = $VictoryScreen
	victory_screen.visible = false
	# Initialize large random list for level 2
	for i in range(40):
		levels[2][0].append(i + 1)
	levels[2][0].shuffle()

	label.text = "Level " + str(level_number)
	stair_start = levels[1][0]
	algorithm_options = levels[1][1]
	executor.algorithm_done.connect(thedisplay.check_display)
	thedisplay.display_sorted.connect(self.new_level)
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


func new_level():
	await get_tree().create_timer(5).timeout
	level_number += 1
	if level_number > levels.size():
		victory_screen.visible = true
		victory_screen.play("gif_animation")
	else:
		print("New level: ", level_number)
		label.text = "Level " + str(level_number)
		executor.reset()
		stair_start = levels[level_number][0]
		algorithm_options = levels[level_number][1]
		button.button_options(algorithm_options)
		executor.initialize_stairs(stair_start.size(), stair_start)
		var scene = load("res://scenes/hamster.tscn")
		var hampter = scene.instantiate()
		hampter.goal = $HamsterGoal
		hampter.global_position = $StartPos.global_position
		add_child(hampter)


func _on_victory_screen_animation_looped() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
