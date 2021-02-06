extends Node2D
# A canvas to host the minigames on.



# Signals the mainloop whether the player has `won` or `lost` the current
# minigame.
signal won( secret )
signal lost

# The canonical list of minigames.
var Minigames = [
	preload( "res://mini/ragdoll/scenes/ragdoll.tscn" ),
	preload( "res://mini/saw/scenes/saw_minigame.tscn" ),
	preload( "res://mini/baseball/scenes/baseball_minigame.tscn" ),
	preload( "res://mini/lose/scenes/lose_minigame.tscn" ),
	preload( "res://mini/za/scenes/za_minigame.tscn" ),
	preload( "res://mini/big_rigs/big_rig_minigame.tscn" ),
	preload( "res://mini/wind/scenes/wind_minigame.tscn" ),
	preload( "res://mini/shooter/scenes/shooter_frame.tscn" ),
	preload( "res://mini/anchovy_quest/scenes/anchovy_game.tscn" ),
	# Comma on last element intentional for efficient diff files.
]

# The minigame currently in progress.
var _minigame: Minigame setget set_minigame


# Instructs the current minigame to decide whether the player has won or lost.
func decide():
	_minigame.decide()


# Sets the current minigame according to the specified ID and adds it to the
# canvas.
func set_minigame( minigame_id ):
	if minigame_id < 0:
		_minigame = \
				preload( "res://mini/ball_tribute/scenes/ball_tribute.tscn" \
				).instance()
	else:
		_minigame = Minigames[minigame_id].instance()
	
# warning-ignore:return_value_discarded
	_minigame.connect( "won", self, "_on_Minigame_won" )
# warning-ignore:return_value_discarded
	_minigame.connect( "lost", self, "_on_Minigame_lost" )
# warning-ignore:return_value_discarded
	_minigame.connect( "found_secret", self, "_on_Minigame_won", [true] )
	
	add_child( _minigame )


# Starts the current minigame.
func start_minigame():
	_minigame.start()


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
func _on_Minigame_won( found_secret: bool = false ):
	emit_signal( "won", found_secret )
