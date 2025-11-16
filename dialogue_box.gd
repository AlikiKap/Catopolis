extends Control

@onready var text_label = $Background/TextLabel
@onready var start_timer = $StartTimer

# This function is called when the node enters the scene tree for the first time.
func _ready():
	# Start with the dialogue box hidden.
	hide()

# This function runs every frame.
func _process(delta):
	# We only check for input if the dialogue box is currently visible.
	if is_visible():
		# "ui_accept" is the default input action for Enter, Space, and controller buttons.
		if Input.is_action_just_pressed("ui_accept"):
			hide()

# This function will be connected to the timer's signal.
func _on_start_timer_timeout():
	# When the timer finishes, show the dialogue box.
	show()
