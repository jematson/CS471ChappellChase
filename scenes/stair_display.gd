extends Node2D

var num_stairs = 15
var stair_heights = []
@onready var background: ColorRect = $BG
@onready var bg_position = background.position
@onready var bg_height = background.size[1]
@onready var bg_width = background.size[0]

func _ready() -> void:
	for i in range(num_stairs):
		stair_heights.append(i+1)
		
	draw_stairs()


func draw_stairs() -> void:
	var stair_width = (bg_width - (10 * (num_stairs+1))) / num_stairs
	for i in range(num_stairs):
		var stairx = bg_position[0] + i*(stair_width + 10) + 10
		var stairh = stair_heights[i]*25
		var stairy = bg_position[1] + bg_height - 50 - stairh
		
		var new_node = ColorRect.new()
		new_node.set_position(Vector2(stairx, stairy))
		new_node.set_size(Vector2(stair_width, stairh))
		new_node.color = Color.WHITE
		add_child(new_node)


func shuffle_stairs():
	var children = get_children()
	print("Deleting stairs...")
	if children.size() > 0:
		for i in range(1,children.size()):
			var child = children[i]
			child.queue_free()
			
	print("Shuffling stairs...")
	stair_heights.shuffle()
	draw_stairs()
	
