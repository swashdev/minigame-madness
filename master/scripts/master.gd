extends Node
# The script for the master scene.


# Export the version number so it can be modified easily from the editor.
# Minigame Madness's version number is the date that this version was
# finalized and built on, rendered as %g.%V.%u, where %g is the two-digit ISO
# week year, %V is the two-digit ISO week number, and %u is the day of the
# week, 1-7, where 1 is Monday and 7 is Sunday.
# See https://en.wikipedia.org/wiki/ISO_week_date for ISO week date
# information.
# "Hotfix" indicates that this version applies a hotfix to an existing
# version and defaults to 0.
export (int, 0, 99) var _version_year
export (int, 01, 53) var _version_week
export (int, 1, 7) var _version_day
export (int) var _hotfix = 0


# Perform final setup.
func _ready():
	$MainMenu.set_version_number( _version_year, _version_week, _version_day,
			_hotfix )


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


# This function is used to handle the "new game" button being pressed.
func _on_new_game():
	# Hide the main menu.
	$MainMenu.hide()
	# Start a new game.
	$Main.new_game()
