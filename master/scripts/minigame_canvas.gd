class_name MinigameCanvas
extends Node2D
# A canvas to host the minigames on.



# Signals the mainloop whether the player has `won` or `lost` the current
# minigame.
signal won
signal lost

# Identifiers for the various minigames.
enum \
{
	RAGDOLL, # ragdoll.tscn
	# Leading comment on last element intentional for diff files.
}

# Packed scenes which indicate which minigames to instance.
export (PackedScene) var Minigame1 # Ragdoll

# The minigame currently in progress.
var _minigame: Minigame setget set_minigame


# Instructs the current minigame to decide whether the player has won or lost.
func decide():
	_minigame.decide()


# Sets the current minigame according to the specified ID and adds it to the
# canvas.
func set_minigame( minigame_id ):
	match minigame_id:
		RAGDOLL:
			_minigame = Minigame1.instance()
	
	_minigame.connect( "won", self, "_on_Minigame_won" )
	_minigame.connect( "lost", self, "_on_Minigame_lost" )
	
	add_child( _minigame )


# Sends the current minigame's instruction up the stack.
func get_instruction():
	return _minigame.get_instruction()


# Performs cleanup to exit the current minigame.
func cleanup():
	_minigame.queue_free()


# Passes the signal that the player has `lost` the minigame up the stack.
func _on_Minigame_lost():
	emit_signal( "lost" )


# Passes the signal that the player has `won` the minigame up the stack.
func _on_Minigame_won():
	emit_signal( "won" )
