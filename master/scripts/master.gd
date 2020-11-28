extends Node
# The script for the master scene.


# The version number.
enum { YEAR = 20, WEEK = 48, DAY = 4 }


# Initialize the master scene.
func _ready():
	# Set the version number label.
	var version = "Version %d.%d.%d" % [YEAR, WEEK, DAY]
	$VersionNumber.text = version


# Main has declared it is ready.
func _on_Main_ready():
	$Main.new_game()


# A button has been pressed on the main menu which requires Master's
# attention.
func _on_MainMenu_button_pressed( button ):
	pass # Replace with function body.
