extends KinematicBody2D
# A script for the player in the Ball Tribute minigame.


# The ball's acceleration due to gravity per second.
const GRAVITY: float = 20.0

# How much the movement keys affect velocity per second.
const MOVE_SPEED: float = 40.0

# How much the movement keys affect upward velocity _immediately_ after
# pressing the "up" key.
const HOP_SPEED: float = 5.0

# The ball's velocity.
var _velocity: Vector2

# How quickly the sprite is spinning in degrees per second.
var _spin: float = 0.0


func _process( delta ):
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

	# Apply gravity.
	_velocity.y += GRAVITY * delta

	# Update position.
	position.x += _velocity.x
	position.y += _velocity.y
