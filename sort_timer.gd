extends Label

var timer_running = false
var remaining_time = 30.0


func _process(delta):
	if timer_running and remaining_time > 0.0:
		remaining_time -= delta
		text = format_time(remaining_time)
	elif timer_running:
		# Uncomment the below to make the timer reset when out of time
		# remaining_time = 30.0
		text = "OUT OF TIME"


func format_time(t):
	var minutes = int(t) / 60
	var seconds = int(t) % 60
	return str(minutes).pad_zeros(2) + ":" + str(seconds).pad_zeros(2)


func start_timer():
	timer_running = true


func stop_timer():
	timer_running = false
