extends Node
# The script for the master scene.


# Export the version number so it can be modified easily from the editor.
# Effective as of version 0.11.0, Minigame Madness uses a Release.Major.Patch
# version numbering system.  Release is incremented once with every entry in
# the Minigame Madness series.  Major is incremented any time something is
# added to the game, such as a new minigame or other feature.  Patch is
# incremented for patches to existing content and hotfixes.  If Patch is 0, it
# will not be displayed.
# The version number which preceded this version numbering system was 21.18.3
export (int) var _version_release
export (int) var _version_major
export (int) var _version_patch

# "Version Type" is a prefix added to the version number to indicate that it is
# a prerelease version, an alpha, &c.
export (int, "Prerelease", "Alpha", "Beta", "Release") var _version_type = 1


# Perform final setup.
func _ready():
	$MainMenu.set_version_number( _version_release, _version_major,
			_version_patch, _version_type )

	# Populate the debug menu.
	var minigames = $Main/MinigameCanvas.Minigames.size()
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
			_on_new_game( 1 )
		"sudden_death":
			_on_new_game( 2 )
		"debug":
			_on_debug_menu()
		"quit":
			_on_quit()


# This function is used to handle the "new game" button being pressed.
# `mode` is the game mode being used.  Default is 0 (GameMode.NORMAL)
func _on_new_game( mode = 0 ):
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
	# Start a new game in debug mode (3) with the given minigame's ID number.
	$Main.new_game( 3, id )
