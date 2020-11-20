extends KinematicBody2D
# A scene for the Fluffy platformer character in the "Lose!" minigame.


# Signals the minigame that Fluffy has died.
signal died

# Fluffy's movement speed.
const MOVE_SPEED: float = 400.0

# Fluffy's movement due to gravity.
const GRAVITY: float = 800.0

# Fluffy's jump velocity.  Note it is negative, because it moves in the
# opposite direction of gravity.
const JUMP: float = -400.0

# Fluffy's current velocity.
var _velocity = Vector2()

# Whether or not Fluffy has died.
var _dead: bool = false


# Fluffy's mainloop.
func _physics_process( delta ):
	# Start by resetting the horizontal velocity.
	_velocity.x = 0
	# Move left & right according to presses of the left & right keys.
	if !_dead:
		if Input.is_action_pressed( "ui_right" ):
			_velocity.x += MOVE_SPEED
			$Sprite.animation = "run"
			$Sprite.play()
		elif Input.is_action_pressed( "ui_left" ):
			_velocity.x -= MOVE_SPEED
			$Sprite.animation = "run"
			$Sprite.play()
		else:
			# Stop animations if no inputs are pressed.
			$Sprite.animation = "default"

		# Adjust sprite orientation based on inputs.
		if Input.is_action_just_pressed( "ui_right" ):
			flip( false )
		if Input.is_action_just_pressed( "ui_left" ):
			flip( true )

	# Move Fluffy.
# warning-ignore:return_value_discarded
	move_and_slide( _velocity, Vector2.UP )

	# Apply gravity.
	if !_dead and is_on_floor():
		# If the player is on the floor, they have the opportunity to jump.
		if Input.is_action_pressed( "ui_select" ):
			_velocity.y = JUMP
		else:
			_velocity.y = 0.0
	else:
		_velocity.y += GRAVITY * delta

	# If dead, Fluffy's sprite will rotate in an assuredly amusing manner.
	if _dead:
		$Sprite.rotation_degrees += 90.0 * delta


# Horizontally flips Fluffy's sprite.
func flip( yn: bool ):
	# Fluffy's sprite is already flipped, so we do the opposite of what the
	# parameters say.
	$Sprite.flip_h = !yn
	# If the sprite is being flipped, we need to adjust the sprite offset to
	# recenter it.  We won't worry too much about animations here, since they
	# don't move the center of mass around too much.
	if yn:
		$Sprite.offset = Vector2( -5.5, -8 )
	else:
		$Sprite.offset = Vector2( -10.5, -8 )


# Fluffy is hit by an obstacle & dies.
func die():
	$Hitbox.set_deferred( "disabled", true )
	$Sprite.animation = "die"
	$Sprite.play()
	_velocity.y = JUMP
	_dead = true
	emit_signal( "died" )
