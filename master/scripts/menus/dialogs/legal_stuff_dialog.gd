extends WindowDialog
# A script for the "Legal Stuff" dialog box.


# This signal will send an instruction to a different dialog box to warn the
# user they are attempting to open a URI.
signal open_external( uri )


# The "Read the Unlicense" button has been toggled, which will show or hide
# the Unlicense and a button to the Unlicense website.
func _on_MMLicenseButton_toggled( button_pressed ):
	$ScrollContainer/VBoxContainer/MMLicenseText.visible = button_pressed
	$ScrollContainer/VBoxContainer/UnlicenseLink.visible = button_pressed


# The link to the Unlicense website has been pressed, so we're going to send
# an instruction to the operating system to visit that website.
func _on_UnlicenseLink_pressed():
	emit_signal( "open_external", "https://unlicense.org/" )


# The link to the Godot license page has been pressed, so we're going to send
# an instruction to the operating system to visit that website.
func _on_GodotLicenseLink_pressed():
	emit_signal( "open_external", "https://godotengine.org/license" )


func _on_DaFontsLink_pressed():
	emit_signal( "open_external", "https://www.dafont.com/modern-dos.font" )


func _on_CC0Link_pressed():
	emit_signal( "open_external",
			"https://creativecommons.org/share-your-work/public-domain/cc0/" )
