extends Minigame
# The "Be a Ragdoll!" minigame.


# A variable which stores whether or not the player has pressed a key
var key_pressed: bool = false

# A boolean which triggers a "jump" animation.
var fluffy_jump: bool = false


# The process for this game is very simple: if the player presses a key, they
# lose
func _process( delta ):
	# Do nothing if the player has already pressed a key
	if _unlock_controls and !key_pressed:
		# Play a little animation depending on which specific key was
		# pressed
		if Input.is_action_pressed( "move_right" ) \
		or Input.is_action_pressed( "move_up" ):
			tip_fluffy_over( "fall_right" )
		elif Input.is_action_pressed( "move_left" ) \
		or Input.is_action_pressed( "move_down" ):
			tip_fluffy_over( "fall_left" )
		elif Input.is_action_pressed( "action" ):
			# Press space to jump!
			$Timer.start()
			key_pressed = true
			fluffy_jump = true

	if fluffy_jump:
		$FluffyRagdoll.position.y -= 400 * delta
		$FluffyRagdoll.rotation_degrees += 360 * delta


# In this particular game, if the timer has gotten all the way down to the
# bottom, that means that the player has won by default
func decide():
	# Stop the timer before proceeding:
	$Timer.stop()

	# If a key has been pressed, signal player lost.  Otherwise, player won.
	if key_pressed:
		emit_signal( "lost" )
	else:
		emit_signal( "won" )


# A function which starts Fluffy's "fall over" animations and freezes user
# input.  Also causes a timer to start which will allow a short pause
# before the player is declared a loser.
func tip_fluffy_over( direction ):
	$FluffyRagdoll.animation = direction
	$FluffyRagdoll.play()
	$Timer.start()

	key_pressed = true


# The timer, which provides a short pause before the player is declared a
# loser, goes off and causes the "lost" signal to be emitted.
func _on_Timer_timeout():
	emit_signal( "lost" )
	
	# a temporary animation I'll use to test that the timer is working:
	#$FluffyRagdoll.flip_v = true
