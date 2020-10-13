extends Button

export var launch_speed : float = 2000
export(float, 0, 1) var toasting_degree = 0.7

var launched : bool = false
onready var toast_start_pos : Vector2 = $"../Toast".position

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_LaunchTestButton_pressed():
	var toast = $"../Toast"
	toast.sleeping = true
	toast.set_physics_position(toast_start_pos)
	toast.launch(launch_speed, toasting_degree)

