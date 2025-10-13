extends Node2D

signal sorted

const InsertionSort = preload("insertion_sort.gd")
const SelectionSort = preload("res://source/selection_sort.gd")
var num_stairs = 15
var stair_heights = []

@onready var display = $StairDisplay


func reset():
	stair_heights = []
	display.empty()


func initialize_stairs(num_stairs, start_shuffle) -> void:
	for i in range(num_stairs):
		stair_heights.append(i + 1)
	display.draw_stairs(stair_heights)
	stair_heights = start_shuffle
	display.update_stair_positions(stair_heights)


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
	emit_signal("sorted")


func call_quicksort():
	quicksort(stair_heights, 0, stair_heights.size() - 1)
	emit_signal("sorted")


func call_insertionsort():
	await InsertionSort.insertion_sort(
		stair_heights,
		func(array: Array): display.update_stair_positions(array),
		self
	)
	emit_signal("sorted")


func call_selectionsort():
	await SelectionSort.selection_sort(
		stair_heights, func(array: Array, i, j): swap(array, i, j), self
	)
	emit_signal("sorted")


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
