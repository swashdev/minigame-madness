extends RigidBody2D
# A scene for the Fluffy platformer character in the "Lose!" minigame.


# Fluffy's movement speed.
const MOVE_SPEED: float = 400.0


# Fluffy's mainloop.
func _process( delta ):
	# Move left & right according to presses of the left & right keys.
	if Input.is_action_pressed( "ui_right" ):
		position.x += MOVE_SPEED * delta
		$Sprite.animation = "run"
		$Sprite.play()
	elif Input.is_action_pressed( "ui_left" ):
		position.x -= MOVE_SPEED * delta
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
