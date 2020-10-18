extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func show_screen():
	var accent_color = Color(GM.bg_color).lightened(0.18)
	visible = true
	$Background.color = GM.bg_color
	# Score
	$Score.text = Util.format_score(GM.last_score)
	# Input
	$User_form/EnterName.caret_blink = true
	$User_form/EnterName.set_placeholder("Enter Name")
	$User_form/EnterName.get_stylebox("focus").border_color = accent_color
	$User_form/Submit.get_stylebox("hover").bg_color = GM.bg_color
	$User_form/Submit.get_stylebox("normal").bg_color = Color(GM.bg_color).darkened(0.25)
	$User_form/Submit.get_stylebox("pressed").bg_color = Color(GM.bg_color).darkened(0.25)
	$ButtonRestart.get_stylebox("hover").bg_color = GM.bg_color
	$ButtonRestart.get_stylebox("normal").bg_color = Color(GM.bg_color).darkened(0.25)
	$ButtonRestart.get_stylebox("pressed").bg_color = Color(GM.bg_color).darkened(0.25)
	$ButtonLeaderboard.get_stylebox("hover").bg_color = GM.bg_color
	$ButtonLeaderboard.get_stylebox("normal").bg_color = Color(GM.bg_color).darkened(0.25)
	$ButtonLeaderboard.get_stylebox("pressed").bg_color = Color(GM.bg_color).darkened(0.25)
	$AnimationPlayer.play("show")
	
