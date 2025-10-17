extends Label

var timer_running = false
var remaining_time = 30.0
var death_screen : AnimatedSprite2D

func _ready():
	death_screen = $DeathScreen
	death_screen.visible = false

func _process(delta):
	if timer_running and remaining_time > 0.0:
		remaining_time -= delta
		text = format_time(remaining_time)
	elif timer_running:
		# Uncomment the below to make the timer reset when out of time
		# remaining_time = 30.0
		death_screen.visible = true
		death_screen.play("gif_animation")


func format_time(t):
	var minutes = int(t) / 60
	var seconds = int(t) % 60
	return str(minutes).pad_zeros(2) + ":" + str(seconds).pad_zeros(2)


func start_timer():
	timer_running = true


func stop_timer():
	timer_running = false

func _on_death_screen_animation_looped():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
