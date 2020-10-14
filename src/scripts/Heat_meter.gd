extends Node2D

var level = 1
var progress = 0
var max_level = 4

var state = "stop"

func update_progress():
	var percent = degrees_to_percent($Progress.rotation_degrees)
	progress = int(round(percent))
	level = percent_to_level(progress)
	
func percent_to_level(percent):
	var current_level = clamp(percent / (100 / max_level) + 1, 1, max_level)
	return int(current_level)

func percent_to_degrees(percent):
	return (percent / 100) * 180
	
func degrees_to_percent(degrees):
	return (degrees / 180) * 100

func _process(delta):
	if state == "measuring":
		update_progress()

func start():
	$Animator.play("show")
	yield($Animator, "animation_finished")
	yield(get_tree().create_timer(0.3), "timeout")
	state = "measuring"
	$Animator.play("progress_loop")
	
func stop():
	$Animator.stop()
	state = "stop"
	print_debug(progress)
	print_debug(level)
