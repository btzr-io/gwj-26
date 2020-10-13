extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Lever.connect("on_active_update", self, "handle_active_update")
	pass # Replace with function body.


func handle_active_update(active_state):
	if active_state:
		$Animator.play("launch_hold")
	else:
		$Animator.play("launch_release")

# Position to instance the slice of bread
func get_spawn_position():
	return $Box/Spawn.global_position
