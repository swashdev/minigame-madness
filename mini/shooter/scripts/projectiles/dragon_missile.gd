extends Projectile2D
# A script for the DragonMissile from the shoot 'em up game.


# At what y coordinate the missile will detonate.
const BOOM_AT_Y: float = 120.0

# The speed the missile will go once it's fired.
const SPEED: float = 200.0

# Whether or not the missile has exploded.
var _exploded: bool = false


# Reset the missile's collision shape on game start.
# Testing has shown that the missile's hit box is too large after the game has
# already been run once, presumably because it's not being reset properly for
# some reason.  This function will reset the hit box explicitly when the game
# starts.
func _ready():
	$CollisionShape2D.shape.set_radius( 5.909 )


# `blow_up` when the missile reaches a certain y coordinate.
func _process( delta ):
	if not _exploded:
		if position.y <= BOOM_AT_Y:
			blow_up()
	else:
		var alpha = $BigBoom.color.a
		if alpha > 0.0:
			alpha -= 1.0 * delta
			$BigBoom.color = Color( 1, 1, 1, alpha )
		else:
			queue_free()


# Signal the mainloop to spawn a BigBoom at the current y coordinates and
# then delete self.
func blow_up():
	_exploded = true
	$CollisionShape2D.shape.set_radius( 120 )
	set_speed( 0.0 )
	$Sprite.hide()
	$BigBoom.show()
	$DeathTimer.start()


# The missile will be fired.
func fire():
	# Enable collision detection.
	$CollisionShape2D.set_deferred( "disabled", false )
	set_speed( SPEED )


func _on_DeathTimer_timeout():
	$CollisionShape2D.set_deferred( "disabled", true )
