extends Node2D

const InsertionSort = preload("insertion_sort.gd")
var num_stairs = 15
var stair_heights = []
@onready var display = $StairDisplay


func _ready() -> void:
	for i in range(num_stairs):
		stair_heights.append(i + 1)
	display.draw_stairs(stair_heights)


func shuffle_stairs():
	stair_heights.shuffle()
	display.update_stair_positions(stair_heights)


func bubble_sort():
	var n = stair_heights.size()
	for i in range(n - 1):
		for j in range(n - i - 1):
			if stair_heights[j] > stair_heights[j + 1]:
				var temp = stair_heights[j]
				stair_heights[j] = stair_heights[j + 1]
				stair_heights[j + 1] = temp

				display.update_stair_positions(stair_heights)

				await get_tree().create_timer(0.3).timeout


func call_quicksort():
	quicksort(stair_heights, 0, num_stairs - 1)


func call_insertionsort():
	await InsertionSort.insertion_sort(
		stair_heights,
		func(array: Array): display.update_stair_positions(array),
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
	display.update_stair_positions(array)
	await get_tree().create_timer(0.3).timeout


func quicksort(array, low, high):
	if low < high:
		var pivot_index = await partition(array, low, high)

		quicksort(array, low, pivot_index - 1)

		quicksort(array, pivot_index + 1, high)
