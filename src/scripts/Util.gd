extends Node

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
