extends Projectile2D
# A script for the arrow from the "Lose!" minigame.


# The arrow strikes Fluffy who, of course, must die.
func _on_Arrow_body_entered( body ):
	body.die()
	queue_free()
