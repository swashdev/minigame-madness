extends Minigame


# This number will be multiplied by the wind strength to determine how quickly
# the player will tip over.
const WIND_STRENGTH: float = 90.0

# How many degrees the player rotates per keypress.
const PLAYER_SPEED: float = 10.0

# The max amount of rotation in either direction before the player loses
const MAX_ROTATION: float = 45.0

# Determines how fast the wind is and which direction it's going.
var wind: float

# The rate of change in `wind` speed per second.
var _wind_diff: float

# Indicates that the player is dead.
var dead: bool = false


# Initializes the initial wind speed, the final wind speed, and the second-by-
# second difference.
func _ready():
	var wind_1 = rand_range( 0.0, 0.5 )
	var wind_2 = rand_range( 0.5, 1.0 )
	if randi() % 2 == 0:
		wind_1 *= -1.0
	if randi() % 2 == 0:
		wind_2 *= -1.0
	_wind_diff = (wind_1 - wind_2) / 4.0
	wind = wind_1


# The minigame's mainloop.
func _process( delta ):
	if _unlock_controls and not dead:
		# Rotate the player according to the wind speed and direction
		$Player.rotation_degrees += WIND_STRENGTH * wind * delta
		# Rotate the player according to user input.
		if Input.is_action_just_pressed( "move_right" ):
			$Player.rotation_degrees += PLAYER_SPEED
		if Input.is_action_just_pressed( "move_left" ):
			$Player.rotation_degrees -= PLAYER_SPEED
		# Flip the player sprite based on current rotation.
		if $Player.rotation_degrees < 0.0:
			$Player.flip_h = false
		if $Player.rotation_degrees > 0.0:
			$Player.flip_h = true
		blink_prompts()
		# Determine player death.
		if $Player.rotation_degrees * sign( $Player.rotation ) > MAX_ROTATION:
			dead = true
			stop()
			emit_signal( "lost" )
			$Player.position.x += 20 * sign( $Player.rotation )
		# Adjust the wind speed.
		wind -= _wind_diff * delta

	# If they die, the player falls off the pillar.
	if dead:
		$Player.position.y += 480.0 * delta
		$Player.position.x += WIND_STRENGTH * wind * delta
		$Player.rotation_degrees += 90 * sign( $Player.rotation ) * delta


# Finish the game by locking the controls and stopping the blinking prompts.
func stop():
	_unlock_controls = false
	$LeftKey.dim()
	$RightKey.dim()


# Blink the prompts based on the player's rotation.
func blink_prompts():
	if $Player.rotation_degrees > 5.0:
		$RightKey.dim()
		$LeftKey.blink()
	elif $Player.rotation_degrees < -5.0:
		$LeftKey.dim()
		$RightKey.blink()
	else:
		$LeftKey.dim()
		$RightKey.dim()


# The player wins by default when the timer runs out.
func decide():
	stop()
	emit_signal( "won" )
