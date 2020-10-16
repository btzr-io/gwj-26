extends Node2D

const TOAST = preload("res://scenes/toaster/Toast.tscn")
const MIN_LAUNCH_SPEED = 1000
const MAX_LAUNCH_SPEED = 4000

# Called when the node enters the scene tree for the first time.
func _ready():
	$Lever.connect("on_active_update", self, "handle_active_update")
	$Animator.connect("animation_finished", self, "handle_animation_finished")
	pass # Replace with function body.


func handle_animation_finished(anim_name):
	var played_backwards = $Animator.current_animation_position == 0
	if anim_name == "launch_hold" && !played_backwards:
		$Heat_meter.start()

func handle_active_update(active_state):
	if active_state:
		$Animator.play("launch_hold")
	elif !$Lever.clicked:
		$Heat_meter.stop()
		$Animator.play("launch_release")
		yield(get_tree().create_timer(0.3), "timeout")
		launch_toast()
	else:
		$Heat_meter.stop()
		$Animator.play_backwards("launch_hold")


func launch_toast():
	var launch_speed = 1500 + ( $Heat_meter.progress  * $Heat_meter.level * 10 )
	launch_speed = clamp(launch_speed, MIN_LAUNCH_SPEED, MAX_LAUNCH_SPEED)
	print_debug(launch_speed)
	var toasting_degree = 0.15 * $Heat_meter.level
	var toast = TOAST.instance()
	get_tree().current_scene.add_child(toast)
	toast.global_position = $Spawn.global_position
	toast.launch(launch_speed, toasting_degree)

# Position to instance the slice of bread
func get_spawn_position():
	return $Box/Spawn.global_position
