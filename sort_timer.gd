extends Label

var timer_running = false
var elapsed_time = 30.0

func _process(delta):
	if timer_running:
		elapsed_time -= delta
		text = format_time(elapsed_time)


func format_time(t):
	var minutes = int(t) / 60
	var seconds = int(t) % 60
	return str(minutes).pad_zeros(2) + ":" + str(seconds).pad_zeros(2)


func start_timer():
	timer_running = true


func stop_timer():
	timer_running = false
