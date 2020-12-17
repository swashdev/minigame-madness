extends Projectile2D
# A script for the arrow from the "Lose!" minigame.


# The arrow strikes Fluffy who, of course, must die.
func _on_Arrow_collided( data ):
	var body = data.get_collider()
	body.die()
	queue_free()
