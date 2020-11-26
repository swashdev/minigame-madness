extends PathFollow2D
# A script for the star spawner from the shoot 'em up minigame.


# A signal which tells the starfield where to spawn the star.
signal spawn_star( x_coordinate )


# When the timer runs out, move to a random location and then tell the
# starfield to spawn a star.
func _on_Timer_timeout():
	unit_offset += randf()
	emit_signal( "spawn_star", position.x )
