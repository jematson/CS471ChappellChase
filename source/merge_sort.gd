extends RefCounted


static func merge(stair_heights: Array, left, mid, right, update_stairs: Callable, node: Node):
	var n1 = mid - left + 1
	var n2 = right - mid

	# Create temp vectors
	var L: Array
	var R: Array

	# Copy data to temp vectors L[] and R[]
	for i in range(n1):
		L.append(stair_heights[left + i])
	for j in range(n2):
		R.append(stair_heights[mid + 1 + j])

	var i = 0
	var j = 0
	var k = left

	# Merge the temp vectors back
	# into arr[left..right]
	while i < n1 && j < n2:
		if L[i] <= R[j]:
			stair_heights[k] = L[i]
			update_stairs.call(stair_heights)
			await node.get_tree().create_timer(0.3).timeout
			i += 1
		else:
			stair_heights[k] = R[j]
			update_stairs.call(stair_heights)
			await node.get_tree().create_timer(0.3).timeout
			j += 1
		k += 1
	# Copy the remaining elements of L[],
	# if there are any
	while i < n1:
		stair_heights[k] = L[i]
		update_stairs.call(stair_heights)
		await node.get_tree().create_timer(0.3).timeout
		i += 1
		k += 1

	# Copy the remaining elements of R[],
	# if there are any
	while j < n2:
		stair_heights[k] = R[j]
		update_stairs.call(stair_heights)
		await node.get_tree().create_timer(0.3).timeout
		j += 1
		k += 1


static func merge_sort_recurse(
	stair_heights: Array, left, right, update_stairs: Callable, node: Node
):
	if left >= right:
		return
	var mid = left + (right - left) / 2
	await merge_sort_recurse(stair_heights, left, mid, update_stairs, node)
	await merge_sort_recurse(stair_heights, mid + 1, right, update_stairs, node)
	await merge(stair_heights, left, mid, right, update_stairs, node)


static func merge_sort(stair_heights: Array, update_stairs: Callable, node: Node):
	await merge_sort_recurse(stair_heights, 0, stair_heights.size() - 1, update_stairs, node)
