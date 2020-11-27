extends Projectile2D
# A script for the DragonMissile from the shoot 'em up game.


# This signal instructs the gameloop to spawn a BigBoom at the given y
# coordinate.
signal big_boom( y_coordinate )

# At what y coordinate the missile will detonate.
const BOOM_AT_Y: float = 120.0

# The speed the missile will go once it's fired.
const SPEED: float = 200.0

# Whether or not the missile has exploded.
var _exploded: bool = false


# `blow_up` when the missile reaches a certain y coordinate.
func _process( _delta ):
	if not _exploded:
		if position.y <= BOOM_AT_Y:
			blow_up()


# Signal the mainloop to spawn a BigBoom at the current y coordinates and
# then delete self.
func blow_up():
	emit_signal( "big_boom", position.y )
	_exploded = true
	$CollisionShape2D.shape.set_radius( 120 )
	set_speed( 0.0 )
	hide()
	$DeathTimer.start()


# The missile will be fired.
func fire():
	# Enable collision detection.
	$CollisionShape2D.set_deferred( "disabled", false )
	set_speed( SPEED )


func _on_DeathTimer_timeout():
	$CollisionShape2D.set_deferred( "disabled", true )
