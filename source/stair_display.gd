extends Node2D

const InsertionSort = preload("insertion_sort.gd")
var num_stairs = 15
var stair_heights = []
var stairs = []
var indices = []
@onready var background: ColorRect = $BG
@onready var bg_position = background.position
@onready var bg_height = background.size[1]
@onready var bg_width = background.size[0]
@onready var bottom_floor = bg_position[1] + bg_height - 50


func _ready() -> void:
	for i in range(num_stairs):
		stair_heights.append(i + 1)

	draw_stairs()


func draw_stairs() -> void:
	var stair_width = (bg_width - (10 * (num_stairs + 1))) / num_stairs
	var blue_increment = 0.0
	for i in range(num_stairs):
		var stairx = bg_position[0] + i * (stair_width + 10) + 10
		var stairh = stair_heights[i] * 25
		var stairy = bottom_floor - stairh

		indices.append(Vector3(i, stairx, stairy))
		var new_node = StairRect.new()
		new_node.value = i + 1
		new_node.height = stairh
		new_node.set_position(Vector2(stairx, stairy))
		new_node.target_pos = (Vector2(stairx, stairy))
		new_node.set_size(Vector2(stair_width, stairh))
		new_node.color = Color(0.5, 0.7, blue_increment)
		add_child(new_node)
		stairs.append(new_node)
		blue_increment += 1.0 / 15.0


func shuffle_stairs():
	stair_heights.shuffle()
	update_stair_positions()


func update_stair_positions():
	for index in range(stair_heights.size()):
		var value = stair_heights[index]
		for stair in stairs:
			if stair.value == value:
				var target_x = indices[index].y
				var target_y = bottom_floor - stair.height
				stair.target_pos = Vector2(target_x, target_y)
				break


func bubble_sort():
	var n = stair_heights.size()
	for i in range(n - 1):
		for j in range(n - i - 1):
			if stair_heights[j] > stair_heights[j + 1]:
				var temp = stair_heights[j]
				stair_heights[j] = stair_heights[j + 1]
				stair_heights[j + 1] = temp

				update_stair_positions()

				await get_tree().create_timer(0.3).timeout


func call_quicksort():
	quicksort(stair_heights, 0, num_stairs - 1)


func call_insertionsort():
	await InsertionSort.insertion_sort(
		stair_heights,
		func(): update_stair_positions(),
		func(array: Array, i, j): swap(array, i, j),
		self
	)


func partition(array, low, high):
	var pivot_value = array[high]
	var i = low - 1

	for j in range(low, high):
		if array[j] <= pivot_value:
			i += 1
			swap(array, i, j)
	await get_tree().create_timer(0.3).timeout
	swap(array, i + 1, high)
	return i + 1


func swap(array, i, j):
	var tmp = array[i]
	array[i] = array[j]
	array[j] = tmp
	update_stair_positions()
	await get_tree().create_timer(0.3).timeout


func quicksort(array, low, high):
	if low < high:
		var pivot_index = await partition(array, low, high)

		quicksort(array, low, pivot_index - 1)

		quicksort(array, pivot_index + 1, high)
