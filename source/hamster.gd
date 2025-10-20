extends CharacterBody2D

@export var speed = 300
@export var goal: Node2D

var readytostart = false

@onready var executer = $"../AlgorithmExecuter"
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D


func _ready() -> void:
	executer.algorithm_done.connect(start)
	nav_agent.target_reached.connect(reached_goal)
	makepath()


func _physics_process(_delta: float) -> void:
	if readytostart:
		if !(is_zero_approx(nav_agent.distance_to_target())):
			var dir = to_local(nav_agent.get_next_path_position()).normalized()
			self.velocity = dir * speed
			self.move_and_slide()
		else:
			reached_goal()


func makepath() -> void:
	nav_agent.target_position = goal.global_position


func start() -> void:
	await get_tree().create_timer(2.5).timeout
	readytostart = true


func reached_goal() -> void:
	queue_free()
