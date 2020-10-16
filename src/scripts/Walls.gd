extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var layers = ["Front", "Back", "Middle"]
export(int) var expand_level setget set_expand_level

func expand_walls(level):
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
