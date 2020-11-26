extends Area2D
# A script for the BigBoom effect from the shoot 'em up minigame.


# The level of transparency at which the BigBoom will stop colliding with
# enemies.
const COLLISION_ALPHA: float = 0.8

# The level of transparency the BigBoom will lose per second.
const LOSE_TRANSPARENCY: float = 3.0


# When ready, make sure to position the `ColorRect` so that its position
# matches the position of the `BigBoom`.
func _ready():
	$ColorRect.rect_position = global_position


# The BigBoom's mainloop.  As soon as it spawns, it will start to fade away.
func _process( delta ):
	var alpha = $ColorRect.get_color().a
	# If the alpha is 0, delete self.
	if alpha <= 0.0:
		queue_free()
	# If the alpha is <= the minimum, stop colliding with enemies.
	elif alpha <= COLLISION_ALPHA:
		$CollisionShape2D.set_deferred( "disabled", true )
	# Reduce transparency.
	alpha -= LOSE_TRANSPARENCY * delta
	$ColorRect.color = Color( 1, 1, 1, alpha )
