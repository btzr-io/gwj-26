extends Camera2D
export var move_speed : float = 0.05
var following_node : Node2D = null
var last_follow_position : Vector2 = Vector2()

# SHAKE
var noise_y = 0
var trauma = 0.0  # Current shake strength.
var trauma_power = 2  # Trauma exponent. Use [2, 3].
var decay = 0.8  # How quickly the shaking stops [0, 1].
var max_offset = Vector2(0, 75)  # Maximum hor/ver shake in pixels.
var max_roll = 0.1  # Maximum rotation in radians (use sparingly).
onready var noise = OpenSimplexNoise.new()

func _ready():
	randomize()
	noise.seed = randi()
	noise.period = 4
	noise.octaves = 2

#for debug purpose
export var DEBUG : bool = false
var debug_node_toggle : bool = false

func add_trauma(amount):
	trauma = min(trauma + amount, 1.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()
	
	if following_node == null:
		return
	
	last_follow_position = following_node.global_position
	
	#Movement
	var distance = $Origin.global_position.distance_to(following_node.global_position)
	var distance_modifier = abs(distance) / 150
	# Increase speed if object is too far
	var smooth_speed = move_speed * distance_modifier 
	var new_position = lerp(global_position.y, following_node.global_position.y, smooth_speed * delta)
	# Clamp camera position to limits
	global_position.y = clamp(new_position, -INF, 960)


func set_following_node(node : Node2D):
	following_node = node
	if node != null:
		last_follow_position = node.position

func shake():
	var amount = pow(trauma, trauma_power)
	noise_y += 1
	rotation = max_roll * amount * noise.get_noise_2d(noise.seed, noise_y)
	offset.x = max_offset.x * amount * noise.get_noise_2d(noise.seed*2, noise_y)
	offset.y = max_offset.y * amount * noise.get_noise_2d(noise.seed*3, noise_y)
