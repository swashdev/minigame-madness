extends Control
# A script for the main menu for Minigame Madness.


# Used to signal Master that a button has been pressed which requires its
# attention.
signal button_pressed( button )

# Used to signal Master that the music has been muted.
signal music_muted( button_toggled )

var _sequence: int = 0


func _process( _delta ):
	if _sequence < 9:
		if Input.is_action_just_pressed( "move_up" ):
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
		elif Input.is_action_just_pressed( "action" ):
			if _sequence == 8:
				$Menu/Buttons/DebugButton.show()
				_sequence += 1
			else:
				_sequence = 0


# Sets the version number for the label.
func set_version_number( release: int, major: int, patch: int,
		build_type: int = 1 ):
	var version = "%d.%d" % [release, major]
	if patch > 0:
		version = "%s.%d" % [version, patch]

	var type: String
	match build_type:
		0: # Prerelease
			type = "Prerelease"
		1: # Alpha
			type = "Alpha"
		2: # Beta
			type = "Beta"
		_: # Release
			type = "Version"

	var full_version_string = "%s %s" % [type, version]
	$VersionNumberLabel.text = full_version_string


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
