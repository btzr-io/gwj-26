extends Node


# Declare member variables here. Examples:
var score = 0
var max_score = 0
var last_score = 0
var combo_count = 0
var player_name = ""
var bg_color = Util.COLORS[0]

const STATE = {
	MAIN_SCREEN  = 0,
	PLAYING = 1,
	GAME_OVER = 2,
}


var game_over = false
var state = STATE.MAIN_SCREEN

# Called when the node enters the scene tree for the first time.
func _ready():
	SilentWolf.configure({
		"api_key": "tUU6V3PmFV1WhrSmABeH08PdT2Afm1OS20swstEV",
		"game_id": "CarbUp1",
		"game_version": "1.0.0",
		"log_level": 1
		})
	SilentWolf.configure_scores({
		"open_scene_on_close": "res://scenes/Screens/Main.tscn"
		})


func restart_game():
	GM.game_over = false
	GM.state = GM.STATE.MAIN_SCREEN
	get_tree().reload_current_scene()
