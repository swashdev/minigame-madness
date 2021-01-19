extends KinematicBody2D
# The anchovy from the "Anchovy Quest" minigame.


# A signal emitted when the achnovy is hit by an obstacle.
signal hit

# A signal emitted when firing a projectile.
signal shoot( location, direction )

# The player's top speed.
const MAX_SPEED: float = 400.0

# The difference in speed per second.
const ACCELERATION: float = 400.0
# The number of degrees the player can turn in one second.
const ROTATIONAL_SPEED: float = 180.0

# Whether or not the player is active.
var allow_movement: bool = false

# The player's current speed.
var _speed: float = 0.0
var _direction: float = -90.0
var _velocity: Vector2


# Handle player movement.
func _physics_process( delta ):
	var collision = move_and_collide( _velocity * delta )
	if collision:
		emit_signal( "hit" )

	# Wrap the player around the edges of the screen.
	position.x = wrapf( position.x, 0, 640.0 )
	position.y = wrapf( position.y, 0, 480.0 )


# Handle player inputs.
func _process( delta ):
	if allow_movement:
		var dspeed = ACCELERATION * delta
		var ddir = ROTATIONAL_SPEED * delta

		# Rotate the player on left or right inputs.
		if Input.is_action_pressed( "move_left" ):
			_direction -= ddir
		if Input.is_action_pressed( "move_right" ):
			_direction += ddir

		# Accelerate to MAX_SPEED on an up input, decelerate to 0 on a down.
		if Input.is_action_pressed( "move_up" ):
			if _speed < MAX_SPEED - dspeed:
				_speed += dspeed
			else:
				_speed = MAX_SPEED
		elif Input.is_action_pressed( "move_down" ):
			if _speed > dspeed:
				_speed -= dspeed
			else:
				_speed = 0.0

		# Fire a projectile on a press of the space bar.
		if Input.is_action_just_pressed( "action" ):
			emit_signal( "shoot", $ProjectileSpawnPoint.global_position, \
					rotation_degrees )

		# Recalculate the player's velocity.
		_recalc_velocity()


# This function is used to recalculate the player's velocity.
func _recalc_velocity():
	_velocity = Vector2( _speed, 0 ).rotated( deg2rad( _direction ) )
	rotation_degrees = _direction
