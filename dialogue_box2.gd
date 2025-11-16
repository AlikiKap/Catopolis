# In dialogue_box.gd (The NEW MASTER version)

extends Control

# --- SIGNALS ---
signal dialogue_opened
signal dialogue_closed

# --- EXPORT VARIABLES (for the Inspector) ---
# If you type a message here, the box will show it automatically on start.
@export var start_message: String = "" 
# The delay before the start_message appears.
@export var start_delay: float = 3.0

# --- NODE REFERENCES ---
@onready var text_label = $Background/TextLabel
@onready var timer = $Timer

# This function runs when the node is added to a scene.
func _ready():
	# Always start hidden.
	hide()
	
	# Check if a start_message was provided in the Inspector.
	if not start_message.is_empty():
		# If there's a message, configure and start the timer.
		timer.wait_time = start_delay
		timer.one_shot = true
		timer.start()
	else:
		# If there's no start message, the timer is not needed.
		timer.stop()

# This function runs every frame.
func _process(delta):
	# Only listen for input if we are visible.
	if is_visible():
		if Input.is_action_just_pressed("ui_accept"):
			close_dialogue()

# --- PUBLIC FUNCTION (for cutscenes to use) ---
func show_message(message: String):
	"""Shows the dialogue box with a message provided by another script."""
	text_label.text = message
	show()
	emit_signal("dialogue_opened")

# --- INTERNAL FUNCTIONS ---
func close_dialogue():
	hide()
	print("DialogueBox: Closing dialogue and emitting 'dialogue_closed' signal.")
	emit_signal("dialogue_closed")

# This function is connected to the timer's timeout signal.
func _on_timer_timeout():
	"""This is only used for the automatic start_message."""
	show_message(start_message)
