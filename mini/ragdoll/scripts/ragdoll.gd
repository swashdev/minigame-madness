# `ragdoll.gd`: the script for the ragdoll game


extends "res://shared/scripts/minigame.gd"
class_name Ragdoll


# In this particular game, if the timer has gotten all the way down to the
# bottom, that means that the player has won by default
func decide():
	emit_signal( "won" )


# Upon detecting an input (keyboard stroke) from the player, immediately
# signal a loss
func _input( event ):
	if event is InputEventKey:
		emit_signal( "lost" )


# Philip, fill me in later.
func _process( _delta ):
	pass
