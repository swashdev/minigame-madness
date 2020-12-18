extends PopupPanel
# A panel which displays the credits screen.


signal open_external( uri )

# Hide the credits screen when the "Close" button is pressed.
func _on_CloseButton_pressed():
	hide()


func _on_SkippitybopButton_pressed():
	emit_signal( "open_external", "https://www.newgrounds.com/audio/listen/944805" )


func _on_LoyaltyFreakButton_pressed():
	emit_signal( "open_external", "https://loyaltyfreakmusic.com/" )
