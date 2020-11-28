class_name Main
extends Node
# The main scene for Minigame Madness.


# This signal is used to tell Master that there's been a game over.
signal game_over( result )

# Aliases for the `game_ended` function.
const WON: bool = true
const LOST: bool = false

# The number of lives the player currently has.
var lives = 5
# The number of minigames that have been played.
var played = 0
# The player's current victory streak.
var streak = 0
# Whether or not there is currently a minigame on.
var game_in_progress: bool = false

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


# Initial setup.
func _ready():
	# Seed the random number generator.
	randomize()


# Normal processing.
func _process( _delta ):
	if game_in_progress:
		# Update the progress bar.
		$InGameHUD.update_progress_bar( $GameTimer.time_left )


# Starts a new game.
func new_game():
	reset_everything()
	$InGameHUD.message( "you have four seconds to complete each game", 2 )
	yield( $InGameHUD, "message_exited" )
	$InGameHUD.message( "use the arrow keys and spacebar", 2 )
	yield( $InGameHUD, "message_exited" )
	$InGameHUD.message( "Game Begin" )
	yield( $InGameHUD, "message_exited" )
	do_next_minigame()


# Resets all of the above variables to their default values.
func reset_everything():
	lives = 5
	played = 0
	streak = 0

	$InGameHUD.update_life_counter( lives )
	$InGameHUD.hide_life_counter()
	$InGameHUD.hide_progress_bar()

	reset_arrays()


# Resets the above arrays to their default values.
func reset_arrays():
	minigames_lost = []
	minigames_won = []
	current_minigame = []

	list_minigames = range( 0, $MinigameCanvas.Minigames.size() )


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
	$MinigameCanvas.set_minigame( minigame_id )


# Having completed one minigame, proceed to the next, if any remain.
func do_next_minigame():
	played = played + 1
	if list_minigames.size() == 0:
		# Signal game over.
		game_ended( WON )
	else:
		get_minigame()
		setup_minigame( current_minigame[0] )
		$InGameHUD.message( $MinigameCanvas.get_instruction() )
		# Resume when the message is off-screen
		yield( $InGameHUD, "message_exited" )
		game_in_progress = true
		$InGameHUD.show_progress_bar()
		$InGameHUD.show_life_counter()
		$MinigameCanvas.start_minigame()
		$GameTimer.start()


# Performs "game over" functions.
func game_ended( won: bool = true ):
	if won:
		$InGameHUD.message( "You win!" )
	else:
		$InGameHUD.message( "Game Over." )
	yield( $InGameHUD, "message_exited" )
	emit_signal( "game_over", won )


# The game timer has expired, and it's time to make a decision.
func _on_GameTimer_timeout():
	$MinigameCanvas.decide()
	$InGameHUD.update_progress_bar( 0.0 )


# The player wins a minigame.
func _on_Minigame_won():
	if game_in_progress:
		$GameTimer.stop()
		game_in_progress = false
		streak = streak + 1
		minigames_won = minigames_won + current_minigame
		$InGameHUD.message( "Well-done!" )
		# Resume when the message is off-screen.
		yield( $InGameHUD, "message_exited" )
		$InGameHUD.hide_progress_bar()
		$MinigameCanvas.cleanup()
		do_next_minigame()


# The player loses a minigame.
func _on_Minigame_lost():
	if game_in_progress:
		$GameTimer.stop()
		game_in_progress = false
		streak = 0
		lives = lives - 1
		$InGameHUD.update_life_counter( lives )
		minigames_lost = minigames_lost + current_minigame

		$InGameHUD.message( "Booooo!" )
		# Resume when the message is off-screen.
		yield( $InGameHUD, "message_exited" )
		$InGameHUD.hide_progress_bar()
		$MinigameCanvas.cleanup()

		if( lives <= 0 ):
			game_ended( LOST )
		else:
			do_next_minigame()
