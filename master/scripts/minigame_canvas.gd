extends Node2D
# A canvas to host the minigames on.



# Signals the mainloop whether the player has `won` or `lost` the current
# minigame.
signal won( secret )
signal lost

# The canonical list of minigames.
var Minigames: PoolStringArray = PoolStringArray([
	"res://mini/ragdoll/scenes/ragdoll.tscn",
	"res://mini/saw/scenes/saw_minigame.tscn",
	"res://mini/baseball/scenes/baseball_minigame.tscn",
	"res://mini/platformer/scenes/platformer_minigame.tscn",
	"res://mini/za/scenes/za_minigame.tscn",
	"res://mini/big_rigs/big_rig_minigame.tscn",
	"res://mini/wind/scenes/wind_minigame.tscn",
	"res://mini/shooter/scenes/shooter_frame.tscn",
	"res://mini/anchovy_quest/scenes/anchovy_game.tscn",
	"res://mini/dodge/scenes/dodge.tscn",
	"res://mini/pants/pants_minigame.tscn",
	"res://mini/pitfall/pitfall_minigame_frame.tscn",
	"res://mini/dance/scenes/dance_minigame.tscn",
	"res://mini/goalie/goalie_minigame.tscn",
	"res://mini/jump/jump_minigame.tscn",
	# Comma on last element intentional for efficient diff files.
])

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
				load( "res://mini/ball_tribute/scenes/ball_tribute.tscn" \
				).instance()
	else:
		_minigame = load(Minigames[minigame_id]).instance()
		if OS.is_debug_build():
			print("Getting minigame \"" + Minigames[minigame_id] + "\"")

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
