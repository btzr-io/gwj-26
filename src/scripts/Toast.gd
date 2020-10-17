extends RigidBody2D

export var steer_speed : float = 1000
export var steer_acceleration : float = 4000

signal start_rising
signal start_falling

var falling = false

var next_physics_process_position : Vector2 = Vector2()
var next_physics_process_should_set_position : bool = false
var horizontal_force : float = 0
var last_vertical_velocity = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Origin.set_as_toplevel(true)
	$Marker.set_as_toplevel(true)
	$Max_score.set_as_toplevel(true)
	# $VisibilityEnabler2D.connect("screen_exited", self, "handle_screen_exit")
	connect("start_falling", self, "handle_falling")
	
func handle_falling():
	var score = global_position.distance_to($Origin.global_position)
	# Check for max score
	if score > GM.max_score:
		GM.max_score = stepify(score / 100, 0.1)
		$Max_score.visible = true
		$Max_score.global_position.y = global_position.y
	else:
		# Show last score
		$Marker.visible = true
		$Marker.global_position.y = global_position.y
		# print_debug("falling!! " + str(score / 100, "ft"))


func update_score():
	# Update score
	var score = global_position.distance_to($Origin.global_position)
	GM.score = stepify(score / 100, 0.1)

func _process(delta):
	if !falling:
		update_score()

func _physics_process(delta):
	var horizontal_steering : float = 0
	if Input.is_action_pressed("steer_left"):
		horizontal_steering -= steer_speed
	if Input.is_action_pressed("steer_right"):
		horizontal_steering += steer_speed
	
	var new_horizontal_speed = move_toward(linear_velocity.x, horizontal_steering, steer_acceleration*delta)
	horizontal_force += new_horizontal_speed - linear_velocity.x
	
	if linear_velocity.y * last_vertical_velocity < 0 : #direction of vertical velocity changed
		if linear_velocity.y < 0:
			emit_signal("start_rising")
			falling = false
		else:
			emit_signal("start_falling")
			falling = true
	last_vertical_velocity = linear_velocity.y


func _integrate_forces(state):
	if next_physics_process_should_set_position:
		next_physics_process_should_set_position = false
		state.transform.origin = next_physics_process_position
	state.linear_velocity.x += horizontal_force
	horizontal_force = 0
	state.linear_velocity.y = clamp(state.linear_velocity.y, -2700, 2700)

func set_physics_position(pos : Vector2):
	next_physics_process_position = pos
	next_physics_process_should_set_position = true

func launch(upspeed : float, toasting_degree):
	var cam = $"../FollowingCamera2D"
	if cam:
		cam.set_following_node(self)
	mode=RigidBody2D.MODE_RIGID
	linear_velocity = Vector2(0, -upspeed)
	toasting_degree = clamp(toasting_degree, 0, 1)
	$Sprite.modulate = Color(1-toasting_degree, 1-toasting_degree, 1-toasting_degree)
	emit_signal("start_rising")
