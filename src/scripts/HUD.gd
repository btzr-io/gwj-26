extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const LEADERBOARD = preload("res://addons/silent_wolf/silent_wolf/Scores/Leaderboard.tscn")

var check_box = null

# Called when the node enters the scene tree for the first time.
func _ready():
	check_box = $GameOver/ColorRect/EnterName.get_text()
	
func format_score(n):
	var formated = str(n).pad_zeros(1)
	if formated.split('.').size() <= 1:
		formated += ".0"
	return formated + " M"
	
func _process(delta):
	$Score.text = format_score(GM.score)
	$Combo.text = str(GM.combo_count,"x")
	
	if GM.game_over == true:
		$GameOver.popup()
		$GameOver/ColorRect/EnterName.caret_blink = true
		$GameOver/ColorRect/EnterName.set_placeholder("Enter Name")
		
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
		
	if Input.is_action_pressed("ui_accept"):
		get_tree().reload_current_scene()
		GM.game_over = false
		$GameOver.hide()		

func _on_Submit_pressed():
	GM.player_name = $GameOver/ColorRect/EnterName.get_text()
	print($GameOver/ColorRect/EnterName.get_text())
	
	if GM.player_name == check_box:
		$GameOver/NeedName.popup()
	if GM.player_name != check_box:
		#print("PLAYER NAME IS:")
		#print(GM.player_name)
		SilentWolf.Scores.persist_score(GM.player_name, GM.score)
		yield(SilentWolf.Scores.get_high_scores(), "sw_scores_received") 
		print("Scores: " + str(SilentWolf.Scores.scores))
		#get_tree().change_scene_to(LEADERBOARD)
		GM.game_over = false
		$GameOver.hide()
		get_tree().reload_current_scene()

func _on_Button_pressed():
	$GameOver/NeedName.hide()
		
