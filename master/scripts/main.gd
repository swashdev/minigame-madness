# `main.gd`: Scripts used for the game's mainloop.


extends Node


export (PackedScene) var Ragdoll


# The number of lives the player currently has.
var lives = 5
# The number of minigames that have been played.
var played = 0
# The player's current victory streak.
var streak = 0
# Whether or not there is currently a minigame on.
var game_in_progress: bool = false

# Identifiers for the various minigames.
enum Minigames \
{
	RAGDOLL, # ragdoll.tscn
	# Leading comment on last element intentional for diff files.
}

# A list of minigames to choose from.  This and the other arrays will be
# populated by the `reset_arrays` function.
var list_minigames = []

# Two lists of minigames which the player has lost or won.
var minigames_lost = []
var minigames_won = []

# This one's a special case because it's actually the ID from the `Minigames`
# enum that represents the minigame currently in `Minigame`, it's just stored
# in an array so that it will be easy to concatenate onto one of the other two
# arrays.
var current_minigame = []

# The minigame currently in progress.
var minigame: Minigame


# Resets all of the above variables to their default values.
func reset_everything():
	lives = 1
	played = 0
	streak = 0

	$InGameHUD/LifeCounter.text = "Lives: 5"
	$InGameHUD/LifeCounter.visible = true
	$InGameHUD/Label.visible = false
	$InGameHUD/TimerProgress.visible = false

	reset_arrays()


# Resets the above arrays to their default values.
func reset_arrays():
	minigames_lost = []
	minigames_won = []
	current_minigame = []
	list_minigames = [
		Minigames.RAGDOLL,
		# Leading comma on last element intentional for diff files
		]


# Selects a random minigame.
func get_minigame():
	# Select a random minigame ID from the list of remaining games.
	var select = randi() % list_minigames.size()
	# Copy the ID into `current_minigame`
	current_minigame = [ list_minigames[select] ]
	# Remove this ID from the original list, as we no longer need it.
	list_minigames.remove( select )


# Setup the selected minigame.
func setup_minigame( minigame_id ):
	# Figure out what `minigame` needs to be.
	match minigame_id:
		Minigames.RAGDOLL:
			minigame = Ragdoll.instance()

	# Connect the minigame's "won" and "lost" signals to the relevant
	# functions:
	minigame.connect( "won", self, "_on_Minigame_won" )
	minigame.connect( "lost", self, "_on_Minigame_lost" )

	# Add the minigame to the main node.
	add_child( minigame )


# Having completed one minigame, proceed to the next, if any remain.
func do_next_minigame():
	played = played + 1
	if list_minigames.size() == 0:
		# Show a win message if there are no minigames left.
		$InGameHUD/Label.zoom_in_from_right( "You're Winner!" )
	else:
		get_minigame()
		setup_minigame( current_minigame[0] )
		$InGameHUD/Label.zoom_in_from_right( minigame.get_instruction() )
		# Resume when the message is off-screen
		yield( $InGameHUD/Label, "animation_finished" )
		game_in_progress = true
		$InGameHUD/TimerProgress.visible = true
		$GameTimer.start()


# Initial setup.
func _ready():
	# Seed the random number generator.
	randomize()
	reset_everything()
	do_next_minigame()


# Normal processing.
func _process( _delta ):
	if game_in_progress:
		# Update the progress bar.
		$InGameHUD/TimerProgress.value = $GameTimer.time_left


# The game timer has expired, and it's time to make a decision.
func _on_GameTimer_timeout():
	minigame.decide()


# The player wins a minigame.
func _on_Minigame_won():
	game_in_progress = false
	$InGameHUD/TimerProgress.visible = false
	streak = streak + 1
	minigames_won = minigames_won + current_minigame
	$InGameHUD/Label.zoom_in_from_right( "Well-done!" )
	# Resume when the message is off-screen.
	yield( $InGameHUD/Label, "animation_finished" )
	minigame.queue_free()
	do_next_minigame()


# The player loses a minigame.
func _on_Minigame_lost():
	game_in_progress = false
	$InGameHUD/TimerProgress.visible = false
	streak = 0
	lives = lives - 1
	$InGameHUD/LifeCounter.text = "Lives: %d" % lives
	minigames_lost = minigames_lost + current_minigame

	if( lives <= 0 ):
		$InGameHUD/Label.zoom_in_from_right( "You lose!" )
		minigame.queue_free()
	else:
		$InGameHUD/Label.zoom_in_from_right( "Booooo!" )
		# Resume when the message is off-screen.
		yield( $InGameHUD/Label, "animation_finished" )
		minigame.queue_free()
		do_next_minigame()
