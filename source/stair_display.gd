extends Node2D

var current_stairs = []
var indices = []
@onready var background: ColorRect = $BG
@onready var bg_position = background.position
@onready var bg_height = background.size[1]
@onready var bg_width = background.size[0]
@onready var bottom_floor = bg_position[1] + bg_height - 10

signal display_sorted

func empty():
	current_stairs = []
	indices = []
	var children = get_children()
	for i in range(children.size() - 1):
		children[i + 1].queue_free()


func draw_stairs(stair_array) -> void:
	current_stairs = []
	var num_stairs = stair_array.size()
	var stair_width = (bg_width - (10 * (num_stairs + 1))) / num_stairs
	var blue_increment = 0.0
	for i in range(num_stairs):
		var stairx = bg_position[0] + i * (stair_width + 10) + 10
		var stairh = stair_array[i] * ((bg_height - 20) / num_stairs)
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
		current_stairs.append(new_node)
		blue_increment += 1.0 / num_stairs


func update_stair_positions(new_stairs):
	for index in range(new_stairs.size()):
		var height = new_stairs[index]
		for stair in current_stairs:
			if stair.value == height:
				var target_x = indices[index].y
				var target_y = bottom_floor - stair.height
				stair.target_pos = Vector2(target_x, target_y)
				break



func check_display():
	await get_tree().process_frame
	while(true):
		var sorted = true
		for stair in current_stairs:
			if stair.position.x != indices[stair.value - 1][1]:
				sorted = false
				break
		if sorted:
			emit_signal("display_sorted")
			break
		await get_tree().process_frame
