extends KinematicBody2D
# A script for the player in the Ball Tribute minigame.


# A signal to inform the gameloop that the ball's to the wall.
signal collided( location, degrees, collision )

# The ball's acceleration due to gravity per second.
const GRAVITY: float = 20.0

# How much the movement keys affect velocity per second.
const MOVE_SPEED: float = 40.0

# How much the movement keys affect upward velocity _immediately_ after
# pressing the "up" key.
const HOP_SPEED: float = 5.0

# Whether or not to allow movement.
var allow_movement: bool = false

# Whether or not to do a "win animation."
var _won: bool = false

# The ball's velocity.
var _velocity: Vector2

# How quickly the sprite is spinning in degrees per second.
var _spin: float = 0.0


func _physics_process( delta ):
	var accel = MOVE_SPEED * delta
	if Input.is_action_just_pressed( "move_up" ):
		_velocity.y -= HOP_SPEED
	elif Input.is_action_pressed( "move_up" ):
		_velocity.y -= accel
	if Input.is_action_pressed( "move_down" ):
		_velocity.y += accel
	if Input.is_action_pressed( "move_right" ):
		_velocity.x += accel
		_spin += accel
	if Input.is_action_pressed( "move_left" ):
		_velocity.x -= accel
		_spin -= accel

	# Spin the ball
	$Sprite.rotation_degrees += _spin

	# Cancel out velocity if we're doing the win animation.
	if _won:
		_velocity = Vector2( 0.0, 100.0 )
	else:
		# Apply gravity.
		_velocity.y += GRAVITY * delta

	# Note that this `if` statement ignores velocity but does not prevent the
	# ball from spinning.  This is intentional, as it reflects a harmless
	# oversight in the early entries of jmtb02's Ball series.
	if allow_movement:
		# Update position and detect collision.
		var collision = move_and_collide( _velocity )

		# If the ball collides with a wall, signal the gameloop.
		if collision:
			emit_signal( "collided", position, $Sprite.rotation_degrees,
					collision )
	# If we've already won the minigame, don't do collision, just do movement.
	elif _won:
# warning-ignore:return_value_discarded
		move_and_slide( _velocity )


# The ball will respawn at the given coordinates.
func respawn( location ):
	position = location
	_velocity = Vector2( 0, 0 )
	_spin = 0.0


# Start the minigame by unlocking movement.  Note that this function will
# reset any velocity and spin that the ball might have gained while it was
# waiting.  This is intentional.  See the comment on line 50.
func start():
	allow_movement = true
	respawn( position )


# Lock movement when the minigame ends.
func stop():
	allow_movement = false


# If the "won" signal is emitted by the minigame, stop taking inputs and
# collisions and make a note to do a "win animation"
func _on_Minigame_won():
	stop()
	$CollisionShape2D.set_deferred( "disabled", true )
	_won = true
