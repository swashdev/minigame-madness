tool
extends "res://shared/scripts/ui/keys/key_prompt.gd"
# An extension of the normal key prompt script which enables the labels that
# are used to specify what the spacebar does in-game.


# This variable is sort of a cheat used to change the text of the spacebar's
# label.
export(String) var _label = "" setget set_label


# When the label is set, change the text on the Label.
func set_label( new_label: String ):
	_label = new_label
	$Label.set_text( new_label )

	# If we are currently in the editor, notify the editor that the property
	# list has changed so that we can see the new label.
	if Engine.editor_hint:
		property_list_changed_notify()
