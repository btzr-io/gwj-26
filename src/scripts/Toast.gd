extends RigidBody2D

export var steer_speed : float = 200


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	var horizontal_steering : float = 0
	if Input.is_action_pressed("steer_left"):
		horizontal_steering -= steer_speed
	if Input.is_action_pressed("steer_right"):
		horizontal_steering += steer_speed
	apply_central_impulse(Vector2(horizontal_steering*delta,0))

func launch(upspeed : float, toasting_degree):
	mode=RigidBody2D.MODE_RIGID
	apply_central_impulse(Vector2(0,-upspeed))
