extends Node2D


export var total_jams : int = 500
export var total_butters : int = 5
export var min_spawn_x : float = 20
export var max_spawn_x : float = 700

const JAM = preload("res://scenes/Items/Jam.tscn")
const BUTTER = preload("res://scenes/Items/Butter.tscn")

onready var cam : Camera2D = $"../FollowingCamera2D"

var highest_item : Node2D = null
var lowest_item : Node2D = null
var noise : OpenSimplexNoise = OpenSimplexNoise.new()

func calculate_xpos_for_butter(pos_y : float):
	var pos_x = noise.get_noise_1d(pos_y)
	pos_x = Util.map_valuef(pos_x, -1, 1, 0, min_spawn_x, max_spawn_x)
	return pos_x

func spawn_items():
	#Spawn butters
	var total_height : float = 2 * get_viewport().size.y
	var interval : float = total_height / total_butters
	for i in range(total_butters):
		var y_pos : float = interval * i
		var x_pos : float = calculate_xpos_for_butter(y_pos)
		var item : Node2D = BUTTER.instance()
		item.position = Vector2(x_pos, y_pos)
		add_child(item)
		print("placed butter at "+String(x_pos)+";"+String(y_pos))
	
	#TODO: spawn jams

# Called when the node enters the scene tree for the first time.
func _ready():
	#Configure noise
	noise.seed = randi()
	noise.octaves = 4
	noise.period = 20.0
	noise.persistence = 0.8
	spawn_items()



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
