extends Node2D
# A script for the slicer in the "Slice the 'Za!" minigame.


# How quickly the slicer rotates along its axis in degrees per second.
const ROTATE_SPEED: float = 180.0


# The slicer's mainloop.
func _process( delta ):
	if Input.is_action_pressed( "move_right" ):
		rotation_degrees += ROTATE_SPEED * delta
	elif Input.is_action_pressed( "move_left" ):
		rotation_degrees -= ROTATE_SPEED * delta
