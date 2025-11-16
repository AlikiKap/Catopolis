extends CharacterBody2D

@export var speed: float = 500.0
@onready var sprite = $CharacterSprite

const ANIMATION_SPEED = 0.2 
var animation_timer = 0.0
var walk_frame = 0

# --- NEW: A variable to control movement ---
var can_move = true

func _physics_process(delta):
	# --- NEW: Only run movement logic if can_move is true ---
	if can_move:
		var direction_x = Input.get_axis("ui_left", "ui_right")
		velocity.x = direction_x * speed
		
		if direction_x != 0:
			sprite.flip_h = direction_x < 0
		
		update_animation(direction_x, delta)
	else:
		# If we can't move, make sure the character stops.
		velocity.x = 0
		update_animation(0, delta) # Show idle animation
		
	move_and_slide()

func update_animation(direction_x, delta):
	# (Your existing animation code doesn't need to change)
	if direction_x != 0:
		animation_timer += delta
		if animation_timer > ANIMATION_SPEED:
			animation_timer = 0.0
			if walk_frame == 0:
				sprite.texture = load("res://walk/walk3.png")
				walk_frame = 1
			else:
				sprite.texture = load("res://walk/walk2.png")
				walk_frame = 0
	else:
		sprite.texture = load("res://walk/walk1.png")
		animation_timer = 0.0

# --- NEW: Functions to handle the signals from the dialogue box ---
func _on_dialogue_opened():
	print("Player: Received dialogue_opened signal! Setting can_move to false.")
	can_move = false

func _on_dialogue_closed():
	print("Player: Received dialogue_closed signal! Setting can_move to true.")
	can_move = true


func _on_dialogue_box_dialogue_opened() -> void:
	pass # Replace with function body.


func _on_dialogue_box_dialogue_closed() -> void:
	pass # Replace with function body.


func _on_StartTimer_timeout() -> void:
	pass # Replace with function body.
