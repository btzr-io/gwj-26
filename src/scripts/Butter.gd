extends Node2D

const SPRITES = [
	preload("res://assets/sprites/items/butter_01.png"),
	preload("res://assets/sprites/items/butter_02.png")
]


onready var cam : Camera2D = $"../".cam
onready var sound_manager = $"../../SoundManager"
var bottom_destroy_height : float = 0

func _on_Area2D_body_entered(_body: RigidBody2D):
	#update speed here
	if _body && _body.name == "Toast":
		_body.linear_velocity.y = -3000
		_body.combo_count = _body.combo_count + 1
		sound_manager.butter_collected()
		#print_debug(_body.combo_count)
		
	
	queue_free()


const MAX_ROT = 45.0

func _ready():
	randomize()
	var sprite_index = randi() % SPRITES.size()
	rotation_degrees = rand_range(-MAX_ROT,MAX_ROT)
	$Area2D/Sprite.texture = SPRITES[sprite_index]
	bottom_destroy_height = get_viewport_rect().size.y * 2 + 200
	
func _process(delta):
	if cam.position.y + bottom_destroy_height < position.y:
		queue_free()
