class_name Minigame
extends Node2D
# The base template for the Minigames in Minigame Madness.


# This signal is used when the player has beaten the minigame, especially if
# the win state occurs before the timer runs down
# warning-ignore:unused_signal
signal won
# Similarly, this signal is used when the player has lost the minigame
signal lost

# A brief string used to give the player some hint as to what they're doing at
# the start of the minigame.  This may also double as the minigame's "name,"
# as in "Doge the Creeps!"
export(String) var _instruction setget ,get_instruction

# Whether the player wins by default when the timer expires.  If not, they
# lose by default.
export(bool) var _win_by_default = false

# Unlocks the controls to allow the minigame's mainloop to process
# instructions.
var _unlock_controls: bool = false


# The getter function for the minigame's instruction string.
func get_instruction():
	return _instruction


# This function is used to force the minigame to decide whether to throw the
# `won` signal or the `lost` signal.  Mostly used if the minigame has not
# given any such signal by the time the timer runs out.
func decide():
	stop()
	if _win_by_default:
		emit_signal( "won" )
	else:
		emit_signal( "lost" )


# Signals the minigame that the game is ready and to start playing.  Generally
# this function will unlock the controls and start any animations, enemy
# spawns, or what have you as appropriate.
func start():
	_unlock_controls = true


# Instructs the minigame to stop.  Generally this will lock the controls, and
# more often than not this function will be called by `decide` when the timer
# runs down.
func stop():
	_unlock_controls = false
