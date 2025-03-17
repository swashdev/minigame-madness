extends KinematicBody2D
# A scene for the Fluffy platformer character in the "Lose!" minigame.


# Signals the minigame that Fluffy has died.
signal died

# Signals the minigame that Fluffy has won.
signal won( cave )

# Signals that Fluffy has entered the cave and is now in the danger zone.
signal entered_cave

# Fluffy's movement speed.
const MOVE_SPEED: float = 400.0

# Fluffy's movement due to gravity.
const GRAVITY: float = 800.0

# Fluffy's jump velocity.  Note it is negative, because it moves in the
# opposite direction of gravity.
const JUMP: float = -400.0

# Whether or not to allow movement.
var allow_movement: bool = false

# Fluffy's current velocity.
var _velocity = Vector2()

# Whether or not Fluffy has died.
var _dead: bool = false
var _won: bool = false

# Whether or not Fluffy can climb the ladder.
var _ladder: bool = false

# Whether or not Fluffy is currently on the ground.
var _grounded: bool = false
var _has_entered_cave: bool = false


# Fluffy's mainloop.
func _physics_process( delta ):
	# Start by resetting the horizontal velocity.
	_velocity.x = 0
	# Move left & right according to presses of the left & right keys.
	if allow_movement and !_dead and !_won:
		if Input.is_action_pressed( "move_right" ):
			_velocity.x += MOVE_SPEED
			$Sprite.animation = "run"
			$Sprite.play()
			# Once and once only, Fluffy will tell the minigame when he has
			# approached the cave.
			if not _has_entered_cave:
				if position.x >= 506.0 and position.y > 200.0:
					_has_entered_cave = true
					emit_signal( "entered_cave" )
					#print_debug( "Danger zone!" )
		elif Input.is_action_pressed( "move_left" ):
			_velocity.x -= MOVE_SPEED
			$Sprite.animation = "run"
			$Sprite.play()
		elif Input.is_action_just_pressed( "move_down" ):
			if position.x >= 567.0 and _grounded:
				fall_over( true )
		else:
			# Stop animations if no inputs are pressed.
			$Sprite.animation = "default"
		# If the player is on the floor, they have the opportunity to jump.
		if _grounded and Input.is_action_pressed( "action" ):
			_velocity.y = JUMP
		# If the player is on the ladder, they have the option to climb it.
		elif _ladder and Input.is_action_pressed( "move_up" ):
			position.y -= MOVE_SPEED * delta

		# Adjust sprite orientation based on inputs.
		if Input.is_action_just_pressed( "move_right" ):
			flip( false )
		if Input.is_action_just_pressed( "move_left" ):
			flip( true )

	# Move Fluffy.
# warning-ignore:return_value_discarded
	move_and_slide( _velocity, Vector2.UP )

	_grounded = is_on_floor() or (_ladder and _velocity.y > -1.0)
	# Apply gravity.
	if _grounded:
		_velocity.y = 0.0
	else:
		_velocity.y += GRAVITY * delta

	# If dead, Fluffy's sprite will rotate in an assuredly amusing manner.
	if _dead:
		$Sprite.rotation_degrees += 90.0 * delta
	else:
		position.x = clamp( position.x, 0.0, 640.0 )
		position.y = clamp( position.y, 0.0, 480.0 )


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


# Fluffy wins the game & falls over.
func fall_over( cave: bool = false ):
	flip( false )
	$Sprite.animation = "fall_over"
	_velocity = Vector2()
	_won = true
	emit_signal( "won", cave )


# Fluffy is inside the effective area of the ladder.
func _on_Ladder_body_entered( _body ):
	_ladder = true


# Fluffy is no longer inside the effective area of the ladder.
func _on_Ladder_body_exited( _body ):
	_ladder = false
