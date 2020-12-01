extends Minigame
# A script for the Ball tribute.


export (PackedScene) var _ghost


# Move the player back to the spawn point.
func respawn():
	$Ball.respawn( $PlayerStart.position )


# The ball has collided with a wall.
func _on_Ball_collided( location, degrees ):
	# Respawn the ball.
	respawn()

	# Create a ghost ball at the player's previous location.
	var ghost = _ghost.instance()
	ghost.position = location
	ghost.rotation_degrees = degrees
	add_child( ghost )
