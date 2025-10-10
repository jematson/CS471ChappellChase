extends RefCounted


static func selection_sort(stair_heights: Array, swap: Callable, node: Node):
	var currentMin
	var minIndex
	for i in range(stair_heights.size()):
		currentMin = stair_heights[i]
		minIndex = i
		for j in range(i, stair_heights.size()):
			if stair_heights[j] < currentMin:
				currentMin = stair_heights[j]
				minIndex = j
		swap.call(stair_heights, minIndex, i)
		await node.get_tree().create_timer(0.3).timeout
