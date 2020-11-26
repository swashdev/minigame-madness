extends PathFollow2D
# A script for the bad guys from the shoot 'em up game.


# Signals the gameloop that the bad guy has exploded and where.
signal exploded( location )

# Determines the speed of the enemy ships in units per second.
const SPEED: float = 40.0


# The bad guys' mainloop.
func _process( delta ):
	# Move along the path.
	offset += SPEED * delta
	# Delete self when at the end of the path.
	if unit_offset >= 1.0:
		queue_free()


# The bad guy explodes, either as a result of contact with a projectile or the
# player.
func explode():
	# Signal an explosion to the mainloop.  The explosion will be located at
	# the sprite's global position.
	emit_signal( "exploded", $AnimatedSprite.global_position )
	# Delete self, we're done.
	queue_free()


# A projectile has entered the bad guy, causing it to explode.
func _on_Area2D_body_entered( body ):
	# Tell the projectile to delete itself.
	body.queue_free()
	# Explode.
	explode()
