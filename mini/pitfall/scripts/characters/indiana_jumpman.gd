extends KinematicBody2D
# A script for the jumpman character from "Get Across!"


# Determines the player's jump, gravity, and movement speed.
const JUMP_SPEED: float = -160.0
const GRAVITY: float = 320.0
const MOVE_SPEED: float = 160.0


# The player's current momentum.
var momentum: Vector2


# The player's mainloop.  Handles basic movement.
func _physics_process( delta ):
	var grounded = is_on_floor()
	
	# Zero out the player's horizontal momentum.
	momentum.x = 0.0

	# Handle left and right movement.
	if Input.is_action_pressed( "move_left" ):
		$Sprite.flip_h = true
		momentum.x -= MOVE_SPEED
		if grounded:
			$Sprite.animation = "walking"
	if Input.is_action_pressed( "move_right" ):
		$Sprite.flip_h = false
		momentum.x += MOVE_SPEED
		if grounded:
			$Sprite.animation = "walking"

	if not grounded:
		momentum.y += GRAVITY * delta
	else:
		momentum.y = 0.0
		if Input.is_action_pressed( "action" ):
			momentum.y = JUMP_SPEED
			$Sprite.animation = "jumping"
		# If the player is grounded and is not jumping or moving, reset his
		# animation.
		elif momentum.x == 0.0:
			$Sprite.animation = "default"

	# Move the player according to what we've determined above.
# warning-ignore:return_value_discarded
	move_and_slide( momentum, Vector2.UP )

	# Clamp the player's position to within the game window.
	position.x = clamp( position.x, 4.0, 76.0 )
