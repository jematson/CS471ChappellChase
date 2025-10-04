extends Node2D

@onready var executer = $AlgorithmExecuter
@onready var button = $AlgorithmMenu


func _ready():
	button.shuffle.connect(executer.shuffle_stairs)
	button.bubble.connect(executer.bubble_sort)
	button.quick.connect(executer.call_quicksort)
