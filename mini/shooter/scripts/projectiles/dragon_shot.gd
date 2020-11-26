extends Projectile2D
# A script for the DragonShot from the shoot 'em up game.


# Pretty much just dequeues the dragon shot.  This is to allow the enemies in
# the game to use the `blow_up` function to detonate the missile without
# causing errors with the player's standard shot.
func blow_up():
	queue_free()
