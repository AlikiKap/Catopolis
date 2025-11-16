# In cutscene.gd (The NEW full version)

extends Control

@export var cutscene_images: Array[Texture2D]
@export var cutscene_dialogues: Array[String]

@onready var dialogue_box = $DialogueBox
@onready var texture_rect = $TextureRect
@onready var timer = $Timer

var current_image_index = 0

func _ready():
	# Make sure the arrays have the same size to avoid errors.
	if cutscene_images.size() != cutscene_dialogues.size():
		print("ERROR: Cutscene image and dialogue arrays must be the same size!")
		get_tree().quit() # Or change to a safe scene

	# Start the cutscene
	show_current_frame()

func show_current_frame():
	# Check if the cutscene is over
	if current_image_index >= cutscene_images.size():
		# THIS IS THE LINE TO CHANGE!
		get_tree().change_scene_to_file("res://school_hallway.tscn") 
		return

	# Display the current image
	texture_rect.texture = cutscene_images[current_image_index]
	
	# Decide what to do next based on the dialogue text
	var current_dialogue = cutscene_dialogues[current_image_index]
	
	if current_dialogue.is_empty():
		print("Decision: This is a TIMED frame. Starting timer.")
		timer.start()
	else:
		print("Decision: This is a DIALOGUE frame. Showing message.")
		dialogue_box.show_message(current_dialogue)


func advance_to_next_frame():
	print("Cutscene: advance_to_next_frame() was called.")
	current_image_index += 1
	show_current_frame()

# This is called automatically when the timer for an automatic frame finishes.
func _on_timer_timeout():
	advance_to_next_frame()

# This is called when the 'dialogue_closed' signal is received from our DialogueBox.
func _on_dialogue_box_dialogue_closed():
	print("Cutscene: Received the 'dialogue_closed' signal!")
	advance_to_next_frame()


func _on_DialogueBox_dialogue_closed() -> void:
	pass # Replace with function body.
