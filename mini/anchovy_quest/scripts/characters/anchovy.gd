extends RigidBody2D
# The anchovy from the "Anchovy Quest" minigame.


# A signal emitted when the achnovy is hit by an obstacle.
signal hit

# The player's top speed.
const MAX_SPEED: float = 200.0

# The difference in speed per second.
const ACCELERATION: float = 100.0
# The number of degrees the player can turn in one second.
const ROTATIONAL_SPEED: float = 90.0

# Whether or not the player is active.
var allow_movement: bool = false


# The player's mainloop.
func _process( delta ):
	# Wrap the player around the edges of the screen.
	if position.x > 640.0:
		position.x = 0.0
	elif position.x < 0.0:
		position.x = 640.0
	if position.y > 480.0:
		position.y = 0.0
	elif position.y < 0.0:
		position.y = 480.0

	if allow_movement:
		var dspeed = ACCELERATION * delta
		var ddir = ROTATIONAL_SPEED * delta

		# Rotate the player on left or right inputs.
		if Input.is_action_pressed( "ui_left" ):
			rotation_degrees -= ddir
		if Input.is_action_pressed( "ui_right" ):
			rotation_degrees += ddir

		# Accelerate to MAX_SPEED on an up input, decelerate to 0 on a down.
		if Input.is_action_pressed( "ui_up" ):
			if linear_velocity.x < MAX_SPEED - dspeed:
				linear_velocity.x = linear_velocity.x + dspeed
			else:
				linear_velocity.x = MAX_SPEED
		elif Input.is_action_pressed( "ui_down" ):
			if linear_velocity.x > dspeed:
				linear_velocity.x = linear_velocity.x - dspeed
			else:
				linear_velocity.x = 0.0


# Detect collisions with obstacles and handle them appropriately.
func _on_Anchovy_body_entered( body ):
	# Show the "ouch" sprite and emit the "hit" signal to signal the
	# minigame that the player's death sequence needs to be started.
	$Sprite.set_visible( false )
	$BoomSprite.set_visible( true )
	emit_signal( "hit" )
