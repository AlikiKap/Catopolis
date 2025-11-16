extends CharacterBody2D

@export var speed: float = 200.0
@onready var sprite = $CharacterSprite

# --- New Animation Variables ---
# How fast the animation plays (in seconds)
const ANIMATION_SPEED = 0.3 
# A timer to count time between frame swaps
var animation_timer = 0.0
# Tracks which walking frame to show (0 for walk2, 1 for walk3)
var walk_frame = 0

func _physics_process(delta):
	# Get input direction
	var direction_x = Input.get_axis("ui_left", "ui_right")
	
	# Set velocity
	velocity.x = direction_x * speed
	
	# Move the character using built-in method
	move_and_slide()

	# Flip sprite when facing left
	if direction_x != 0:
		sprite.flip_h = direction_x < 0
	
	# --- Updated Animation Logic ---
	update_animation(direction_x, delta)

func update_animation(direction_x, delta):
	# Check if the character is walking
	if direction_x != 0:
		# Add the time passed since the last frame to our timer
		animation_timer += delta
		
		# If the timer has passed our animation speed threshold...
		if animation_timer > ANIMATION_SPEED:
			# ...reset the timer
			animation_timer = 0.0
			
			# Switch to the other frame
			if walk_frame == 0:
				sprite.texture = load("res://walk/walk2.png")
				walk_frame = 1 # Next frame will be the first one
			else:
				sprite.texture = load("res://walk/walk3.png")
				walk_frame = 0 # Next frame will be the second one
				
	# If the character is standing still
	else:
		# Set the idle texture
		sprite.texture = load("res://walk/walk1.png")
		# Reset the timer so animation starts fresh next time
		animation_timer = 0.0
