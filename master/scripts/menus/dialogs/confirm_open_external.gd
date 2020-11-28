extends ConfirmationDialog
# A script for a dialog box confirming the user wants to open an external
# link.


# The dialog's base text.  {URL} will be replaced with the URI we're warning
# the user about.
var _base_text = "You have clicked on a link to the following external URL:\n{URL}\nPlease confirm you would like to open this link."

# The URI we are currently warning the user about.
var _uri: String = ""


# The dialog has been signalled with an external URI.  Popup with a message
# confirming the destination.
func _on_open_external( uri ):
	dialog_text = _base_text.format( uri, "{URL}" )
	_uri = uri
	popup()


# The player has confirmed they would like to open the URI.
func _on_confirmed():
# warning-ignore:return_value_discarded
	OS.shell_open( _uri )
	_uri = ""
