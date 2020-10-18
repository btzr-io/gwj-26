extends Node2D

var layers = ["Front", "Back", "Middle"]
export(int) var expand_level setget set_expand_level

var noise : OpenSimplexNoise
onready var cam = $"../FollowingCamera2D"
var color_start_index : int = 0

func init_noise(noise_seed : int):
	noise = OpenSimplexNoise.new()
	noise.seed = noise_seed
	noise.octaves = 2
	noise.period = 20.0
	noise.persistence = 0.3


func expand_walls(level):
	randomize()
	#$Background/ColorRect.rect_size.y += 1920  * level
	#$Background/ColorRect.rect_position.y -= 1920 * level
	#$ColorRect.rect_size.y += 1920  * level
	#$ColorRect.rect_position.y -= 1920 * level
	#$ColorRect.color = Color(COLORS[randi() % COLORS.size()])
	color_start_index = randi() % Util.COLORS.size()
	
	init_noise(randi())
	
	for layer in layers:
		# Left side
		var wall_left_path = "Left" + "/" + layer + "/Wall"
		var wall_left = get_node_or_null(wall_left_path)
		
		if wall_left:
			var wall_height =  wall_left.region_rect.size.y
			var grow_top = wall_height * level
			var position_top = grow_top * 0.5
			wall_left.position.y -= position_top
			wall_left.region_rect = wall_left.region_rect.grow_individual(0, grow_top, 0, 0)

		# Right side
		var wall_right_path = "Right" + "/" + layer + "/Wall"
		var wall_right = get_node_or_null(wall_right_path)
		
		if wall_right:
			var wall_height =  wall_right.region_rect.size.y
			var grow_top = wall_height * level
			var position_top = grow_top * 0.5
			wall_right.position.y -= position_top
			wall_right.region_rect = wall_right.region_rect.grow_individual(0, grow_top, 0, 0)
		

func set_expand_level(level):
   expand_level = level
   expand_walls(level)

func get_bg_color_for_ypos(ypos : float)->Color:
	#var r = noise.get_noise_2d(ypos*0.0005,0)
	#r = Util.map_valuef(r,-1,1,0.1,1)
	#var g = noise.get_noise_2d(ypos*0.0005,3)
	#g = Util.map_valuef(g,-1,1,0.1,1)
	#var b = noise.get_noise_2d(ypos*0.0005,7)
	#b = Util.map_valuef(b,-1,1,0.1,1)
	#return Color(r,g,b)
	
	#Fade between the defined colors
	var f : float = ypos*0.0001-2-color_start_index
	var weight = wrapf(f, 0, 1)
	var to_index : int = int(f) % Util.COLORS.size()
	var from_index : int = (int(f)-1) % Util.COLORS.size()
	return lerp(Color(Util.COLORS[from_index]), Color(Util.COLORS[to_index]), weight)
	
func update_bg_color():
	GM.bg_color = get_bg_color_for_ypos(cam.position.y)
	$Ovelrlay/ColorRect.color = GM.bg_color
func _process(delta):
	update_bg_color()
