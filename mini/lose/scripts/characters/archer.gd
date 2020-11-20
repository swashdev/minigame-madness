extends Area2D
# A script for the archer from the "Lose" minigame.


# Signals the minigame to spawn an arrow.
signal shoot( arrow, position )

# A scene representing the projectiles this character will fire.
export (PackedScene) var _arrow


# The archer's timer expires, prompting them to shoot an arrow.
func _on_Timer_timeout():
	emit_signal( "shoot", _arrow, position )


# Fluffy has touched the archer and, naturally, must die.
func _on_Archer_body_entered( body ):
	body.die()
	$CollisionShape2D.set_deferred( "disabled", true )
