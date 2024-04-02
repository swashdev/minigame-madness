extends Minigame
# A script for the Ball tribute.


export (PackedScene) var _ghost


# Unlock the ball when the minigame starts.
func start():
	$Ball.start()


# Lock the ball's position when the minigame ends.
func stop():
	$Ball.stop()


# Move the player back to the spawn point.
func respawn( location, degrees ):
	$Ball.respawn( $PlayerStart.position )

	# Create a ghost ball at the player's previous location.
	var ghost = _ghost.instance()
	ghost.position = location
	ghost.rotation_degrees = degrees
	add_child( ghost )


# The ball has collided with a wall.
func _on_Ball_collided( location, degrees, collision: KinematicCollision2D ):
	if collision.get_collider_id() != $Goal.get_instance_id():
		# Respawn the ball.
		respawn( location, degrees )
	else:
		$Ball.position = $Goal.position
		$Ball._velocity = Vector2( 0.0, 0.0 )
		$Ball._spin = 5.0
		emit_signal( "won" )
