extends Node2D


onready var butter_sound : AudioStreamPlayer = $ButterCollectedSound
onready var jam_sound : AudioStreamPlayer = $JamCollectedSound


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func butter_collected():
	butter_sound.play()

func jam_collected():
	jam_sound.play()
