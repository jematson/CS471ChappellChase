extends RefCounted


static func selection_sort(stair_heights: Array, swap: Callable, node: Node):
	var current_min
	var min_index
	for i in range(stair_heights.size()):
		current_min = stair_heights[i]
		min_index = i
		for j in range(i, stair_heights.size()):
			if stair_heights[j] < current_min:
				current_min = stair_heights[j]
				min_index = j
		swap.call(stair_heights, min_index, i)
		await node.get_tree().create_timer(0.3).timeout
