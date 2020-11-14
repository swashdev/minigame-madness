extends RigidBody2D
# The anchovy from the "Anchovy Quest" minigame.


# A signal emitted when the achnovy is hit by an obstacle.
signal hit


# Detect collisions with obstacles and handle them appropriately.
func _on_Anchovy_body_entered( body ):
	# Show the "ouch" sprite and emit the "hit" signal to signal the
	# minigame that the player's death sequence needs to be started.
	$Sprite.set_visible( false )
	$BoomSprite.set_visible( true )
	emit_signal( "hit" )
