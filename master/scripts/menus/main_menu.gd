extends Control
# A script for the main menu for Minigame Madness.


# Used to signal Master that a button has been pressed which requires its
# attention.
signal button_pressed( button )


# Sets the version number for the label.
func set_version_number( year: int, week: int, day: int, hotfix: int = 0 ):
	var version = "%d.%d.%d" % [year, week, day]
	var hotfix_label
	if hotfix > 0:
		hotfix_label = "-hotfix%d" % hotfix
	else:
		hotfix_label = ""
	var full_version_string = "Version %s%s" % [version, hotfix_label]
	$VersionNumberLabel.text = full_version_string


# The "New Game" button has been pressed.  It's time to signal Master.
func _on_NewGameButton_pressed():
	emit_signal( "button_pressed", "new_game" )
