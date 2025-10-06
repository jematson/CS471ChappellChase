extends RefCounted


static func insertion_sort(
	stair_heights: Array, update_stairs: Callable, swap: Callable, node: Node
):
	for i in range(stair_heights.size()):
		for j in range(stair_heights.size()):
			if stair_heights[j] > stair_heights[i]:
				swap.call(stair_heights, i, j)
				update_stairs.call(stair_heights)
				await node.get_tree().create_timer(0.3).timeout
