extends Area2D

var player_is_inside = false
@export var target_scene_path: String = "res://teachersRoom.tscn"
var is_changing_scene = false

func _process(delta):
	if is_changing_scene:
		return

	# This print will tell us if the script thinks the player is inside
	if player_is_inside:
		print("Player is inside, waiting for 'E' key...")

		if Input.is_action_just_pressed("interact"):
			is_changing_scene = true
			print("'E' key pressed! Changing scene.") # This is our goal
			get_tree().change_scene_to_file(target_scene_path)

func _on_body_entered(body):
	# This print will confirm if ANY body enters
	print("Something entered the door. It was: ", body.name)

	if body.name == "CharacterBody2D":
		# This print confirms it recognized the player
		print("Player has been recognized!")
		player_is_inside = true

func _on_body_exited(body):
	if body.name == "CharacterBody2D":
		print("Player has exited.")
		player_is_inside = false
