extends KinematicBody2D
# A script for the player character in the "Put on Pants!" minigame.


const MOVE_SPEED: float = 200.0


var allow_movement: bool = false


# Pants Man will move left and right within the boundaries of the screen.
func _process( delta ):
	if allow_movement:
		if Input.is_action_pressed( "move_left" ):
			if position.x > 0.0:
				position.x -= MOVE_SPEED * delta
			else:
				position.x = 0.0
		if Input.is_action_pressed( "move_right" ):
			if position.x < 640.0:
				position.x += MOVE_SPEED * delta
			else:
				position.x = 640.0
