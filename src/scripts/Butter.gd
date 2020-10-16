extends Node2D

onready var cam : Camera2D = $"../".cam
var bottom_destroy_height : float = 0

func _on_Area2D_body_entered(_body: RigidBody2D):
	#update speed here
	if _body.name == "Toast":
		_body.linear_velocity.y = -4000
	
	queue_free()


func _ready():
	bottom_destroy_height = get_viewport_rect().size.y * 2 + 200

func _process(delta):
	if cam.position.y + bottom_destroy_height < position.y:
		queue_free()
