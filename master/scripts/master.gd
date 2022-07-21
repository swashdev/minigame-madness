extends Node
# The script for the master scene.


# Perform final setup.
func _ready():
	$MainMenu.set_version_number(Version.MAJOR, Version.MINOR, Version.PATCH, 3)

	# Populate the debug menu.
	var minigames = $Main/MinigameCanvas.Minigames
	$DebugMenu.populate_menu( minigames )


# Main has signalled game over.
func _on_Main_game_over( _result ):
	# Un-hide the main menu.
	$MainMenu.show()


# A button has been pressed on the main menu which requires Master's
# attention.
func _on_MainMenu_button_pressed( button ):
	match button:
		"new_game":
			_on_new_game()
		# Endurance Mode and Sudden Death are game modes 1 and 2.
		"endurance_mode":
			_on_new_game(Global.GameMode.ENDURANCE)
		"sudden_death":
			_on_new_game(Global.GameMode.SUDDEN_DEATH)
		"debug":
			_on_debug_menu()
		"quit":
			_on_quit()


# This function is used to handle the "new game" button being pressed.
# `mode` is the game mode being used.  Default is GameMode.NORMAL
func _on_new_game(mode = Global.GameMode.NORMAL):
	# Hide the main menu.
	$MainMenu.hide()
	# Start a new game.
	$Main.new_game( mode )


# This function is used to handle the debug menu button being pressed.
func _on_debug_menu():
	# Hide the main menu.
	$MainMenu.hide()
	# Show the debug menu.
	$DebugMenu.show()


# This function is used to handle the "quit" button being pressed.
func _on_quit():
	get_tree().quit()


# The "back" button has been pressed on the debug menu.  Go back to the main
# menu.
func _on_DebugMenu_debug_closed():
	$DebugMenu.hide()
	$MainMenu.show()


# A debug button has been pressed in the debug menu.
func _on_debug_button_pressed( id ):
	# Hide the debug menu.
	$DebugMenu.hide()
	# Start a new game in debug mode with the given minigame's ID number.
	$Main.new_game(Global.GameMode.DEBUG, id)
