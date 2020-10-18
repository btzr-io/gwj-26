extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var toaster = null
var lever = null

# Called when the node enters the scene tree for the first time.
func _ready():
	toaster = get_tree().current_scene.get_node_or_null("Toaster")
	if toaster:
		lever = toaster.get_node_or_null("Lever")

func _process(delta):
	var inverse = ( 1.0 - lever.progress ) + 0.25
	var smooth_time = 10 * pow(inverse, inverse)  * delta
	modulate.a = lerp( modulate.a, lever.progress, smooth_time)
	position.y = lerp(position.y, 200 * lever.progress, smooth_time)
