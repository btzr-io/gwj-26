extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
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
		
	if Input.action_press("ui_cancel"):
		get_tree().quit()

func _on_Submit_pressed():
	get_tree().quit()
