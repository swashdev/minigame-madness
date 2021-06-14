extends KinematicBody2D
# A script for the jumpman character from "Get Across!"


# Signals the minigame that the player has died.
signal died;


# Determines the player's jump, gravity, and movement speed.
const JUMP_SPEED: float = -160.0
const GRAVITY: float = 320.0
const MOVE_SPEED: float = 160.0


# The player's current momentum.
var momentum: Vector2


# Whether or not the player's controls have been locked.
var _unlock_controls: bool = false

# Whether or not to do the victory march.
var _victory_march: bool = false


# The player's mainloop.  Handles basic movement.
func _physics_process( delta ):
	var grounded = is_on_floor()
	
	# Zero out the player's horizontal momentum, unless we're doing a
	# victory march.
	momentum.x = 0.0 if not _victory_march else MOVE_SPEED

	if _unlock_controls:
		# Handle left and right movement.
		if Input.is_action_pressed( "move_left" ):
			$Sprite.flip_h = true
			momentum.x -= MOVE_SPEED
		if Input.is_action_pressed( "move_right" ):
			$Sprite.flip_h = false
			momentum.x += MOVE_SPEED

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
		# If the player is grounded and moving, start their walking animation.
		else:
			$Sprite.animation = "walking"

	# Move the player according to what we've determined above.
# warning-ignore:return_value_discarded
	move_and_slide( momentum, Vector2.UP )
	
	# Check to see if we collided with the kill zone (collision layer 2)
	for i in get_slide_count():
		var collision = get_slide_collision( i )
		if( collision.collider.collision_layer == 2 ):
			die()

	# Clamp the player's position to within the game window unless we're doing
	# a victory march.
	if not _victory_march:
		position.x = clamp( position.x, 4.0, 76.0 )


# Unlocks the player's controls.
func unlock():
	_unlock_controls = true


# Locks the player's controls.
func lock():
	_unlock_controls = false


# Kills the player.
func die():
	lock()
	$Sprite.animation = "dead"
	emit_signal( "died" )


# The player has entered the win zone, so do a victory march.
func _on_WinZone_body_entered( _body ):
	lock()
	_victory_march = true
