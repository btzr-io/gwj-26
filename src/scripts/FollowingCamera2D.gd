extends Camera2D

export var min_zoom : float = 0.7
export var max_zoom : float = 1.3
export var node_speed_at_min_zoom : float = 100
export var node_speed_at_max_zoom : float = 320
export var zoom_speed : float = 2
export var move_speed : float = 0.05

var following_node : Node2D = null
var last_follow_position : Vector2 = Vector2()

var shaking : bool = false
var shake_intensity : float = 0
var shake_duration : float = 0
var shake_time : float = 0

#for debug purpose
export var DEBUG : bool = false
var debug_node_toggle : bool = false

# Called when the node enters the scene tree for the first time.
#func _ready():
	#if(DEBUG):
		#set_following_node($"../RotatingNode2D2/Sprite")

func map_valuef(value : float, from_min : float, from_max : float, to_min : float, to_max : float, clamp_result : bool)->float:
	var weight : float = (value - from_min) / (from_max - from_min)
	var res : float = lerp(to_min, to_max, weight)
	if clamp_result:
		res = clamp(res, to_min, to_max)
	return res

func debug_process():
	if Input.is_action_just_pressed("DEBUG_1"):
		set_following_node($"../RotatingNode2D2/Sprite" if debug_node_toggle else $"../RotatingNode2D/Sprite")
		debug_node_toggle = !debug_node_toggle
	
	if Input.is_action_just_pressed("DEBUG_2"):
		shake(500,1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if following_node == null:
		return
	
	#Zoom
	if delta > 0:
		var following_delta_pos : Vector2 = following_node.global_position - last_follow_position
		var following_delta_distance : float = following_delta_pos.length()
		var following_speed : float = following_delta_distance / delta
		var target_zoom : float = map_valuef(following_speed, node_speed_at_min_zoom, node_speed_at_max_zoom, min_zoom, max_zoom, true)
		var actual_zoom : float = move_toward(zoom.x, target_zoom, zoom_speed * delta)
		zoom = Vector2(actual_zoom, actual_zoom)
	
	last_follow_position = following_node.global_position
	
	
	#Movement
	position = lerp(position, following_node.global_position, move_speed)
	
	#Shaking
	if shaking:
		shake_time += delta
		if shake_time > shake_duration:
			shaking = false
		else:
			var intensity = shake_intensity * (shake_duration - shake_time) / shake_duration
			var shake_movement = Vector2(sin(shake_time * 40), sin(shake_time * 45))
			position += shake_movement * intensity * delta
	
	if DEBUG:
		debug_process()


func set_following_node(node : Node2D):
	following_node = node
	if node != null:
		last_follow_position = node.position

func shake(intensity : float, duration : float):
	shake_time = 0
	shake_intensity = intensity
	shake_duration = duration
	shaking = true
