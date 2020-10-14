extends RigidBody2D

export var steer_speed : float = 200

var next_physics_process_position : Vector2 = Vector2()
var next_physics_process_should_set_position : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


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

func _integrate_forces(state):
	if next_physics_process_should_set_position:
		next_physics_process_should_set_position = false
		state.transform.origin = next_physics_process_position

func set_physics_position(pos : Vector2):
	next_physics_process_position = pos
	next_physics_process_should_set_position = true

func launch(upspeed : float, toasting_degree):
	var cam = $"../FollowingCamera2D"
	cam.set_following_node(self)
	mode=RigidBody2D.MODE_RIGID
	linear_velocity = Vector2(0, -upspeed)
	toasting_degree = clamp(toasting_degree, 0, 1)
	$Sprite.modulate = Color(1-toasting_degree, 1-toasting_degree, 1-toasting_degree)
