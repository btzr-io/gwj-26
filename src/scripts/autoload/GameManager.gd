extends Node


# Declare member variables here. Examples:
var score = 0
var max_score = 0
var last_score = 0
var combo_count = 0

var player_name = ""

var game_over = false

# Called when the node enters the scene tree for the first time.
func _ready():
	SilentWolf.configure({
		"api_key": "tUU6V3PmFV1WhrSmABeH08PdT2Afm1OS20swstEV",
		"game_id": "CarbUp1",
		"game_version": "1.0.0",
		"log_level": 1
		})
	SilentWolf.configure_scores({
		"open_scene_on_close": "res://scenes/MainPage.tscn"
		})


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
