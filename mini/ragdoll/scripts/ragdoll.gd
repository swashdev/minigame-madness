# `ragdoll.gd`: the script for the ragdoll game


extends "res://shared/scripts/minigame.gd"
class_name Ragdoll


# A variable which stores whether or not the player has pressed a key
var key_pressed: bool = false


# In this particular game, if the timer has gotten all the way down to the
# bottom, that means that the player has won by default
func decide():
	if key_pressed:
		emit_signal( "lost" )
	else:
		emit_signal( "won" )


# A function which starts Fluffy's "fall over" animations and freezes user
# input
func tip_fluffy_over( direction ):
	$FluffyRagdoll.animation = direction
	$FluffyRagdoll.play()
	
	key_pressed = true


# The process for this game is very simple: if the player presses a key, they
# lose
func _process( _delta ):
	# Do nothing if the player has already pressed a key
	if !key_pressed:
		# Play a little animation depending on which specific key was
		# pressed
		if Input.is_action_pressed( "ui_right" ) \
		or Input.is_action_pressed( "ui_up" ):
			tip_fluffy_over( "fall_right" )
		elif Input.is_action_pressed( "ui_left" ) \
		or Input.is_action_pressed( "ui_down" ) \
		or Input.is_action_pressed( "ui_select" ):
			# Placeholder event for animations I haven't completed
			# yet:
			$FluffyRagdoll.flip_h = true
			key_pressed = true
