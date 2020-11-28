extends Node
# The script for the master scene.


# Main has declared it is ready.
func _on_Main_ready():
	$Main.new_game()


# A button has been pressed on the main menu which requires Master's
# attention.
func _on_MainMenu_button_pressed( button ):
	pass # Replace with function body.
