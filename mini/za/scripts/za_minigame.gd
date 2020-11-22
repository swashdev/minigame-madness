extends Minigame
# A script for the "Slice that 'Za!" minigame.


# Used to store whether or not the 'za is fully sliced.
var _sliced: bool = false


# The mainloop for the minigame.
func _process( _delta ):
	if Input.is_action_just_pressed( "action" ):
		$Za.slice()


# Decide whether the player has won the minigame.
# In this minigame, if the player has not already been declared the winner by
# the time the timer expires, they will be declared the winner ONLY if they
# have fully sliced the 'za.
func decide():
	if _sliced:
		emit_signal( "won" )
	else:
		emit_signal( "lost" )


# The 'za has been sliced; make a note of that.
func _on_Za_sliced():
	_sliced = true


# The 'za has been eaten; declare the player victorious.
func _on_Za_eaten():
	emit_signal( "won" )
