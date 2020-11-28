extends Button
# A script for a button on the debug menu.


# This signal informs the debug menu that a debug button has been pressed.
signal debug_button_pressed( id )

# This stores the ID number of a minigame to be passed up to Master when we
# want to debug that minigame.
var _id: int setget set_id, get_id


func set_id( id ):
	_id = id


func get_id() -> int:
	return _id


# When this button is pressed, signal the debug menu and inform them of the
# button's ID.
func _on_DebugMenuButton_pressed():
	emit_signal( "debug_button_pressed", _id )
