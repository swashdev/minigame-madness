extends ScrollContainer
# A script for the debug menu.


# Signals Master that we're debugging a particular minigame.
signal debug_button_pressed( id )

# Signals Master that we're leaving the debug menu.
signal debug_closed

# A template for the debug menu buttons.
var _button = \
		preload( "res://master/scenes/menus/buttons/debug_menu_button.tscn" )


# This function populates the debug menu with buttons given the number of
# minigames.
func populate_menu( minigames ):
	var count: int = 0
	while count < minigames.size():
		var button = _button.instance()
		button.set_text( "Minigame %d" % count )
		button.set_id( count )
		count += 1
		$VBoxContainer.add_child( button )
		button.connect( "debug_button_pressed", self,
				"_on_debug_button_pressed" )


# A debug button has been pressed.  Signal Master with its ID.
func _on_debug_button_pressed( id ):
	emit_signal( "debug_button_pressed", id )


# The "Back" button has been pressed.  Signal master that we're done.
func _on_BackButton_pressed():
	emit_signal( "debug_closed" )
