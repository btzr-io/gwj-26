extends Node2D

const TOAST = preload("res://scenes/toaster/Toast.tscn")
const MIN_LAUNCH_SPEED = 1250
const MAX_LAUNCH_SPEED = 5400

const STATE = {
	SLEEP = 0,
	EJECTED = 2,
	LAUNCHING = 1,
}

var state = STATE.SLEEP

# Called when the node enters the scene tree for the first time.
func _ready():
	$Lever.connect("on_active_update", self, "handle_active_update")
	$Animator.connect("animation_finished", self, "handle_animation_finished")
	pass # Replace with function body.

func _process(delta):
	var is_playing = GM.state == GM.STATE.PLAYING 
	
	if !is_playing:
		GM.state = GM.STATE.PLAYING
		
func handle_animation_finished(anim_name):
	var played_backwards = $Animator.current_animation_position == 0
	if anim_name == "launch_hold" && !played_backwards:
		$Heat_meter.start()

func handle_active_update(active_state):
	# Lever active
	if active_state:
		state = STATE.LAUNCHING
		$Animator.play("launch_hold")
	# Launch toast !
	elif !$Lever.clicked:
		$Heat_meter.stop()
		$Animator.play("launch_release")
		yield(get_tree().create_timer(0.3), "timeout")
		launch_toast()

# Cancel launch
#	else:
#		$Heat_meter.stop()
#		$Animator.play_backwards("launch_hold")


func launch_toast():
	state = STATE.EJECTED
	$Lever.disabled = true
	var launch_speed = 1500 + ( $Heat_meter.progress  * $Heat_meter.level * 25 )
	launch_speed = clamp(launch_speed, MIN_LAUNCH_SPEED, MAX_LAUNCH_SPEED)
	print_debug(launch_speed)
	var toasting_degree = 0.15 * $Heat_meter.level
	var toast = TOAST.instance()
	get_tree().current_scene.add_child(toast)
	toast.global_position = $Spawn.global_position
	toast.launch(launch_speed, toasting_degree)
	yield(get_tree().create_timer(0.2), "timeout")
	toast.z_as_relative = false
	toast.z_index = 2

# Position to instance the slice of bread
func get_spawn_position():
	return $Box/Spawn.global_position
