extends KinematicBody2D
# A script for the jumpman character from "Get Across!"


# Signals the minigame that the player has died.
signal died
signal won


# The player's possible states.
enum States { DEFAULT, VICTORIOUS, DEAD, SWINGING }


# Determines the player's jump, gravity, and movement speed.
const JUMP_SPEED: float = -20.0
const GRAVITY: float = 40.0
const MOVE_SPEED: float = 20.0


# The player's current state.
var _state: int = States.DEFAULT setget , get_state

# The player's current momentum.
var momentum: Vector2

# Whether or not the player's controls have been locked.
var _unlock_controls: bool = false


onready var _sprite = $Sprite


# The player's mainloop.  Handles basic movement.
func _physics_process( delta ):
	# If the player is swinging, all other movement rules are ignored.
	var grounded = is_on_floor()

	# Zero out the player's horizontal momentum, unless we're doing a
	# victory march.
	momentum.x = 0.0 if _state != States.VICTORIOUS else MOVE_SPEED

	if _unlock_controls and _state == States.DEFAULT:
		# Handle left and right movement.
		if Input.is_action_pressed( "move_left" ):
			_sprite.flip_h = true
			momentum.x -= MOVE_SPEED
		if Input.is_action_pressed( "move_right" ):
			_sprite.flip_h = false
			momentum.x += MOVE_SPEED

	if not grounded and _state != States.SWINGING:
		momentum.y += delta * (GRAVITY if _state != States.DEAD \
				else GRAVITY / 2)
	else:
		momentum.y = 0.0
		if _unlock_controls or _state == States.VICTORIOUS:
			if Input.is_action_pressed( "action" ):
				momentum.y = JUMP_SPEED
				_sprite.animation = "jumping"
				# The player has just jumped, so he is no longer grounded.
				grounded = false
			# If the player is grounded and is not jumping or moving, reset
			# his animation.
			elif momentum.x == 0.0:
				_sprite.animation = "default"
			# If the player is grounded and moving, start their walking
			# animation.
			else:
				_sprite.animation = "walking"

	# Move the player according to what we've determined above.
	# If the player is on the ground, he must adhere to any moving platforms he
	# might be standing on.
	var snap: Vector2 = Vector2.DOWN * 4 if grounded else Vector2.ZERO
# warning-ignore:return_value_discarded
	move_and_slide_with_snap( momentum, snap, Vector2.UP )

	# Check to see if we collided with the kill zone (collision layer 2)
	for i in get_slide_count():
		var collision = get_slide_collision( i )
		if( collision.collider.collision_layer == 2 ):
			die()

	# Clamp the player's position to within the game window unless we're doing
	# a victory march.
	if _state == States.DEFAULT:
		position.x = clamp( position.x, 4.0, 76.0 )
		# If the player reaches the other end of the pond, go to victory state.
		if position.x >= 64:
			lock()
			_state = States.VICTORIOUS
			emit_signal( "won" )


# Returns the player's current state.
func get_state():
	return _state


# Unlocks the player's controls.
func unlock():
	_unlock_controls = true


# Locks the player's controls.
func lock():
	_unlock_controls = false


# Kills the player.
func die():
	if _state == States.DEFAULT:
		lock()
		_state = States.DEAD
		_sprite.animation = "dead"
		position.y -= 10
		emit_signal( "died" )


# Causes the player to enter a swinging state.
func start_swinging():
	_state = States.SWINGING
	_sprite.animation = "jumping"
	lock()


# Causes the player to stop swinging.
func stop_swinging():
	_state = States.DEFAULT
	_sprite.animation = "jumping"
	# The player jumps off the vine to give them a little boost.
	momentum.y = JUMP_SPEED
	unlock()
