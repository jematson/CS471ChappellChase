extends RefCounted


static func insertion_sort(
	stair_heights: Array, update_stairs: Callable, node: Node
):
	var key
	for i in range(stair_heights.size()):
		key = stair_heights[i]
		var j = i-1
		while j >= 0 && stair_heights[j] > key:
			stair_heights[j+1] = stair_heights[j]
			update_stairs.call(stair_heights)
			await node.get_tree().create_timer(0.3).timeout
			j = j-1
		stair_heights[j+1] = key
		update_stairs.call(stair_heights)
		await node.get_tree().create_timer(0.3).timeout
