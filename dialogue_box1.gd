# In WelcomeMessage.gd (The NEW version with a timer)

extends Control

@onready var text_label = $Background/TextLabel

# This function runs as soon as the game starts
func _ready():
	# Start with the dialogue box hidden
	hide()

# This function is for closing the box
func _process(delta):
	if is_visible() and Input.is_action_just_pressed("ui_accept"):
		hide()

# --- NEW: This function will be called by the timer ---
func _on_StartTimer_timeout():
	# A simple message for the start of the level
	text_label.text = "Geez...Ms.Clark took my phone again. Well, I can just sneak into the teachers' room and get it back, I guess."
	# Now we show the box
	show()
