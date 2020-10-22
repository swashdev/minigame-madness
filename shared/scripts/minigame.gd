# `minigame.gd`: All minigames will inherit from this class structure.


extends Node2D
class_name Minigame


# A brief string used to give the player some hint as to what they're doing at
# the start of the minigame.  This may also double as the minigame's "name,"
# as in "Doge the Creeps!"
export(String) var instruction setget ,get_instruction


func get_instruction():
	return instruction


# This signal is used when the player has beaten the minigame, especially if
# the win state occurs before the timer runs down
signal won
# Similarly, this signal is used when the player has lost the minigame
signal lost


# This function is used to force the minigame to decide whether to throw the
# `won` signal or the `lost` signal.  Mostly used if the minigame has not
# given any such signal by the time the timer runs out.
func decide():
	emit_signal( "lost" )
