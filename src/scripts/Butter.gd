extends Node2D



func _on_Area2D_body_entered(body):
	#update speed here
	queue_free()
