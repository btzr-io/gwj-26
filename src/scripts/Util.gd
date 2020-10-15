extends Node


func map_valuef(value : float, from_min : float, from_max : float, to_min : float, to_max : float, clamp_result : bool)->float:
	var weight : float = (value - from_min) / (from_max - from_min)
	var res : float = lerp(to_min, to_max, weight)
	if clamp_result:
		res = clamp(res, to_min, to_max)
	return res
