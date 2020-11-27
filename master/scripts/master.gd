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
