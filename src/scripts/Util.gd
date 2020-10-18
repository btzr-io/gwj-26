extends Node

var mask_to_name = {}
var name_to_mask = {}

func format_score(n):
	var formated = str(n).pad_zeros(1)
	if formated.split('.').size() <= 1:
		formated += ".0"
	return formated + " M"

func map_valuef(value : float, from_min : float, from_max : float, to_min : float, to_max : float, clamp_result : bool = false)->float:
	var weight : float = (value - from_min) / (from_max - from_min)
	var res : float = lerp(to_min, to_max, weight)
	if clamp_result:
		res = clamp(res, to_min, to_max)
	return res


func fill_layer_dicts():
	for i in range(1, 21):
		var layer_name = ProjectSettings.get_setting(
			str("layer_names/2d_physics/layer_", i))
		if(not layer_name):
			layer_name = str("Layer ", i)
		var mask: int = pow(2, i-1)
		mask_to_name[mask] = layer_name
		name_to_mask[layer_name] = mask
		#print("layer name: "+layer_name+" mask: "+String(mask))
	
func _ready():
	fill_layer_dicts()
