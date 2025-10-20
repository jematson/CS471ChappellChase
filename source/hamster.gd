extends CharacterBody2D

const speed = 200

@export var goal: Node2D
@export var startPos: Node2D
@onready var executer = $"../AlgorithmExecuter"
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
var readytostart = false

func _ready() -> void:
	executer.algorithm_done.connect(start)
	nav_agent.target_reached.connect(reached_goal)
	makepath()

func _physics_process(_delta: float) -> void:
	if readytostart:
		if !nav_agent.is_target_reached():
			var dir = to_local(nav_agent.get_next_path_position()).normalized()
			self.velocity = dir * speed
			self.move_and_slide()
		else:
			reached_goal()

func makepath() -> void:
	nav_agent.target_position = goal.global_position

func start() -> void:
	readytostart = true

func reached_goal() -> void:
	self.global_position = startPos.global_position
	readytostart = false
