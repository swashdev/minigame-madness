extends Button
# A script for the "new game" buttons on the main menu.


# A string signifying what text appears when the player hovers over the
# button.
export (String) var _descriptive_text


# Initialize the button with its normal text.
func _ready():
	$Label.text = _descriptive_text


# The mouse is hovering over the button.
func _on_NewGameButton_mouse_entered():
	$Label.show()


# The mouse is no longer hovering over the button.
func _on_NewGameButton_mouse_exited():
	$Label.hide()
