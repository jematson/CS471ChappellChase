extends ColorRect
class_name StairRect

var value: int
var target_index: int = 0
var target_pos: Vector2
var height: float 
var speed: float = 400.0

func _process(delta):
	position = position.move_toward(target_pos, speed * delta)
