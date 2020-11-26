extends Area2D
# A script for the player character from the shoot 'em up minigame.


# The player's speed.
const SPEED: float = 400.0

# Whether or not to unlock movement.
var allow_movement: bool = false


# The player's mainloop, pretty much standard movement stuff.
func _process( delta ):
	if allow_movement:
		var speed = SPEED * delta
		if Input.is_action_pressed( "move_right" ):
			position.x += speed
		if Input.is_action_pressed( "move_left" ):
			position.x -= speed
		position.x = clamp( position.x, 20, 220 )
