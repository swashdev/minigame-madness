extends KinematicBody2D
# A script for the pants in the "Put on Pants!" minigame.


# A signal indicating that the pants have collided with the player.
# The pants's index will be sent up the chain so that they can be repositioned
# by the minigame.
signal collided( idx )


# The pants' movement due to gravity.
const GRAVITY = Vector2( 0.0, 400.0 )


# Indicates whether the pants are currently falling.
var falling: bool = true


# The main process for the pants.
func _physics_process( delta ):
	if falling:
		var collision = move_and_collide( GRAVITY * delta )

		# If the pants detect a collision, set position to that of the
		# colliding body to put the pants on and stop falling.
		if collision:
			falling = false
			position = collision.position

			# Signal the game that the pants have collided.
			emit_signal( "collided", get_index() )

		# If the pants fall too low, remove them.
		if position.y > 580.0:
			queue_free()
