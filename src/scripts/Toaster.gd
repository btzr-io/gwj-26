extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


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
	else:
		$Heat_meter.stop()
		$Animator.play_backwards("launch_hold")

# Position to instance the slice of bread
func get_spawn_position():
	return $Box/Spawn.global_position
