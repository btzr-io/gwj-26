extends Node2D

const JAM = preload("res://scenes/Items/Jam.tscn")
const BUTTER = preload("res://scenes/Items/Butter.tscn")

export var item_y_distance : float = 500
export var butter_line_no_jam_spawn_dist : float = 300

onready var cam : Camera2D = $"../FollowingCamera2D"

var min_spawn_x : float = 0
var max_spawn_x : float = 0

var highest_item : Node2D = null
var lowest_item : Node2D = null
var noise : OpenSimplexNoise = OpenSimplexNoise.new()
var next_item_place_y : float = 0
var spawn_butter : bool = true

func calculate_xpos_for_butter(pos_y : float)->float:
	var pos_x = noise.get_noise_1d(pos_y * 0.005)*2
	pos_x = Util.map_valuef(pos_x, -1, 1, min_spawn_x, max_spawn_x, true) # map x pos to scene
	return pos_x

func calculate_xpos_for_jam(pos_y : float)-> float:
	var pos_x : float = randf()
	pos_x = Util.map_valuef(pos_x, 0, 1, min_spawn_x, max_spawn_x)# map x pos to scene
	
	#Check if x pos is near the butter line and move it away
	var butter_x : float = calculate_xpos_for_butter(pos_y) 
	if abs(pos_x - butter_x) < butter_line_no_jam_spawn_dist:
		#return -10000.0
		if pos_x > butter_x:
			pos_x = butter_x + butter_line_no_jam_spawn_dist
		else:
			pos_x = butter_x - butter_line_no_jam_spawn_dist
	return pos_x

func spawn_items_at_y(y_pos):
	#Spawn butter
	if spawn_butter:
		var y_butter : float = y_pos + randf()*100
		var x_pos : float = calculate_xpos_for_butter(y_butter)
		var item = BUTTER.instance()
		item.position = Vector2(x_pos, y_butter)
		add_child(item)
		#print("placed butter at "+String(x_pos)+";"+String(y_butter))
	spawn_butter = !spawn_butter
	
	#Spawn jam
	var y_jam : float = y_pos + randf()*100
	var x_pos = calculate_xpos_for_jam(y_jam)
	if x_pos >= min_spawn_x && x_pos <= max_spawn_x:
		var item = JAM.instance()
		item.position = Vector2(x_pos, y_jam)
		add_child(item)
		#print("placed jam at "+String(x_pos)+";"+String(y_jam))
	
	

# Called when the node enters the scene tree for the first time.
func _ready():
	#Get bounds
	min_spawn_x = $LeftBound.position.x
	max_spawn_x = $RightBound.position.x
	
	#Configure noise
	noise.seed = randi()
	noise.octaves = 4
	noise.period = 20.0
	noise.persistence = 0.8
	
	next_item_place_y = get_top_y()

func get_top_y()->float:
	return cam.position.y - get_viewport_rect().size.y * 0.5 - 200

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var top_y : float = get_top_y()
	
	#Spawn new items on top of the camera view
	while top_y <= next_item_place_y:
		spawn_items_at_y(top_y)
		next_item_place_y = top_y - item_y_distance+(cam.position.y*0.001)
