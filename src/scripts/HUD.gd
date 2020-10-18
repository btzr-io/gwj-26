extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const LEADERBOARD = preload("res://scenes/Screens/Leaderboard.tscn")

var new_name = null
# Called when the node enters the scene tree for the first time.
func _ready():
	$GameOver/User_form/Submit.connect("button_down", self, "handle_submit")
	$GameOver/User_form/EnterName.text = GM.player_name
	$GameOver/ButtonRestart.connect("button_down", self, "handle_restart")
	$GameOver/ButtonLeaderboard.connect("button_down", self, "handle_leaderboard")

func restart_game():
	GM.game_over = false
	GM.state = GM.STATE.MAIN_SCREEN
	get_tree().reload_current_scene()

func _process(delta):
	if GM.state == GM.STATE.PLAYING:
		$Score.text = Util.format_score(GM.score)
	elif GM.score != 0.0:
		GM.score = 0.0
		$Score.text = Util.format_score(GM.score)
	
	if GM.combo_count > 0:
		$Combo.modulate.a = lerp($Combo.modulate.a, 1.0, 5.0 * delta)
		$Combo.text = str(GM.combo_count,"x")

	if GM.combo_count == 0:
				$Combo.modulate.a = lerp($Combo.modulate.a, 0.0, 5.0 * delta)

	if GM.game_over == true && !$GameOver.visible:
		$GameOver.show_screen()

	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()

	if $GameOver.visible && Input.is_action_pressed("ui_accept"):
		restart_game()

	# Prevent empty submit
	if $GameOver/User_form/EnterName.text.empty() && !$GameOver/User_form/Submit.disabled:
		$GameOver/User_form/Submit.disabled = true
	elif !$GameOver/User_form/EnterName.text.empty() && $GameOver/User_form/Submit.disabled:
		$GameOver/User_form/Submit.disabled = false

func show_scores():
	yield(SilentWolf.Scores.get_high_scores(), "sw_scores_received")
	#print("Scores: " + str(SilentWolf.Scores.scores))
	var leaderboard = LEADERBOARD.instance()
	add_child(leaderboard)
	# get_tree().reload_current_scene()

func handle_submit():
	if !$GameOver/User_form/EnterName.text.empty():
		GM.player_name = $GameOver/User_form/EnterName.text
		SilentWolf.Scores.persist_score(GM.player_name, GM.last_score)
		show_scores()

func handle_restart():
	restart_game()

func handle_leaderboard():
	show_scores()

func _on_Button_pressed():
	$User_form/NeedName.hide()
