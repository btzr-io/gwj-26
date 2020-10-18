extends Node2D

export var debug_mode = false

var active = false
var clicked = false
var next_active = false
var prev_active = false
var grabbed_offset = Vector2.ZERO
var mouse_position = Vector2.ZERO

signal on_active_update(active_state)

# Called when the node enters the scene tree for the first time.
func _ready():
	$Handler.connect("input_event", self, "handle_input")
	# Initial position
	$Handler.position = $Limit_top.position
	# Draw debug line for drag limit
	if debug_mode:
		draw_limit()

func handle_input(viewport, event, shape_idx):
	if event is InputEventMouseButton && event.button_index == BUTTON_LEFT && event.pressed:
		clicked = true
		grabbed_offset = $Handler.position - get_global_mouse_position()

func _process(delta):
	# Action released
	if !Input.is_mouse_button_pressed(BUTTON_LEFT) && clicked:
		clicked = false
		if !active:
			$Tween.interpolate_property(
				$Handler, 
				"position", 
				$Handler.position, 
				$Limit_top.position,
				0.72,
				Tween.TRANS_ELASTIC,
				Tween.EASE_IN_OUT
			)
			$Tween.start()
	# Dragging lever
	if !active && clicked:
		mouse_position =  get_global_mouse_position() + grabbed_offset
		# Apply limits
		var limited = clamp(
			mouse_position.y, 
			$Limit_top.position.y, 
			$Limit_bottom.position.y
		)
		# Smooth movement
		limited = lerp($Handler.position.y, limited, 0.4)
		# Update position
		$Handler.position.y = limited
	
	# Lever of the toaster is pressed down
	prev_active = active
	var next_active = clicked && $Handler.position.y >= $Limit_bottom.position.y - 1.0
	
	# Only update on changes
	if next_active != prev_active:
		active = next_active
		emit_signal("on_active_update", active)

func draw_limit():
	$Limit_line.show()
	$Limit_line.points[0] = $Limit_top.position
	$Limit_line.points[1] = $Limit_bottom.position
