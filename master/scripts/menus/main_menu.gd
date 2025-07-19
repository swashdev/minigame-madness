extends Control
# A script for the main menu for Minigame Madness.


# Used to signal Master that a button has been pressed which requires its
# attention.
signal button_pressed( button )

# Used to signal Master that the music has been muted.
signal music_muted( button_toggled )

# Used to signal Master that the music volume has been adjusted.
signal music_volume_changed( new_volume )

var _sequence: int = 0


func _ready():
	$VersionNumberLabel.set_text("Version " + Version.get_nice_version())
	var osl_button = $LegalStuffDialog.get_ok()
	osl_button.set_text("Open-Source Licenses")
	osl_button.connect("pressed", $OpenSourceLicensesDialog, "popup_centered")


func _process( _delta ):
	if _sequence < 10:
		if Input.is_action_just_pressed( "secret_a" ):
			if _sequence == 9:
				$Menu/Buttons/DebugButton.show()
				_sequence += 1
			else:
				_sequence = 0
		elif Input.is_action_just_pressed( "move_up" ):
			if _sequence < 2:
				_sequence += 1
			elif _sequence > 2:
				_sequence = 0
		elif Input.is_action_just_pressed( "move_down" ):
			if _sequence < 2 or _sequence >= 4:
				_sequence = 0
			else:
				_sequence += 1
		elif Input.is_action_just_pressed( "move_right" ):
			if _sequence == 5 or _sequence == 7:
				_sequence += 1
			else:
				_sequence = 0
		elif Input.is_action_just_pressed( "move_left" ):
			if _sequence == 4 or _sequence == 6:
				_sequence += 1
			else:
				_sequence = 0
		elif Input.is_action_just_pressed( "secret_b" ):
			if _sequence == 8:
				_sequence += 1
			else:
				_sequence = 0
		elif Input.is_action_just_pressed( "action" ):
			_sequence = 0


# The "New Game" button has been pressed.  It's time to signal Master.
func _on_NewGameButton_pressed():
	emit_signal( "button_pressed", "new_game" )


# The "Endurance Mode" button has been pressed.  Signal Master.
func _on_EnduranceModeButton_pressed():
	emit_signal( "button_pressed", "endurance_mode" )


# The "Sudden Deatht" button has been pressed.  Signal Master.
func _on_SuddenDeath_pressed():
	emit_signal( "button_pressed", "sudden_death" )


# The "Controls" button has been pressed.  Show a dialog explaning the
# controls.
func _on_ControlsButton_pressed():
	$ControlsDialog.popup_centered()


# The "Credits" button has been pressed.  Open a dialog box.
func _on_CreditsButton_pressed():
	$CreditsDialog.popup( Rect2( Vector2( 0, 20 ), Vector2( 640, 480 ) ) )


# The "Legal Stuff" button has been pressed.  This will open a dialog box
# containing licensing information.
func _on_LegalStuffButton_pressed():
	$LegalStuffDialog.popup_centered()


# The "Debug Menu" button has been pressed.  Signal Master.
func _on_DebugButton_pressed():
	emit_signal( "button_pressed", "debug" )


# The "Mute Music" button has been pressed.  Signal Master.
func _on_MusicButton_toggled( button_pressed ):
	emit_signal( "music_muted", button_pressed )
	$VolumePercentage.visible = not button_pressed


func _on_VolumeSlider_value_changed( value: float ):
	emit_signal( "music_volume_changed", value )
	var new_vol_percent: float = ((value + 80) / 80) * 100
	$VolumePercentage.set_text( "%03.0f%%" % new_vol_percent )
