extends Sprite
# A ghost which appears when the player is respawned.


# The rate at which the sprite's alpha changes per second.
const ALPHA_RATE: float = 500.0


# The ghost's mainloop.
func _process( delta ):
	var alpha = modulate.a
	# Decrease the ghost's opacity.
	alpha -= ALPHA_RATE * delta
	# If the ghost would now be fully transparent, remove it from the scene.
	if alpha <= 0.0:
		queue_free()
	else:
		modulate = Color( 1, 1, 1, alpha )
