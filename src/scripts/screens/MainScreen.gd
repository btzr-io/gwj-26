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
	modulate.a = lerp( modulate.a, lever.progress, 0.4)
	position.y = lerp(position.y, 250 * lever.progress, 0.4)
