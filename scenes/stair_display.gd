extends Node2D


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
		stair_heights.append(i+1)
		
	draw_stairs()


func draw_stairs() -> void:
	var stair_width = (bg_width - (10 * (num_stairs+1))) / num_stairs
	for i in range(num_stairs):

		var stairx = bg_position[0] + i*(stair_width + 10) + 10
		var stairh = stair_heights[i]*25
		var stairy = bottom_floor - stairh
		
		indices.append(Vector3(i,stairx, stairy))
		var new_node = StairRect.new()
		new_node.value = i + 1
		new_node.height = stairh
		new_node.set_position(Vector2(stairx, stairy))
		new_node.target_pos = (Vector2(stairx, stairy))
		new_node.set_size(Vector2(stair_width, stairh))
		new_node.color = Color.WHITE
		add_child(new_node)
		stairs.append(new_node)


func shuffle_stairs():
	var new_order = stair_heights.duplicate()
	new_order.shuffle()
	
	for target_index in range(num_stairs):
		var target_value = new_order[target_index]
		
		for stair in stairs:
			if stair.value == target_value:
				var target_x = indices[target_index].y
				var target_y = bottom_floor - stair.height
				#var target_y = indices[target_index].z
				stair.target_pos = Vector2(target_x, target_y)
				break
