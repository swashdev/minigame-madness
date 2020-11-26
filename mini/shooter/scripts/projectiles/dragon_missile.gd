extends Projectile2D
# A script for the DragonMissile from the shoot 'em up game.


# This signal instructs the gameloop to spawn a BigBoom at the given y
# coordinate.
signal big_boom( y_coordinate )

# At what y coordinate the missile will detonate.
const BOOM_AT_Y: float = 80.0

# The speed the missile will go once it's fired.
const SPEED: float = 200.0


# `blow_up` when the missile reaches a certain y coordinate.
func _process( _delta ):
	if position.y <= BOOM_AT_Y:
		blow_up()


# Signal the mainloop to spawn a BigBoom at the current y coordinates and
# then delete self.
func blow_up():
	emit_signal( "big_boom", position.y )
	queue_free()


# The missile will be fired.
func fire():
	# Enable collision detection.
	$CollisionShape2D.set_deferred( "disabled", false )
	_speed = SPEED
