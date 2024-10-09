extends Node
# The script for the master scene.


# Constants used to determine the status of looking for the "--debug-minigame"
# command-line argument.
enum Arg_Debug_Minigame { SEARCHING, GOT_KEY, GOT_VALUE }


# Set this to any nonnegative value before export to produce a binary which
# opens in Debug Mode for this minigame.
export var debug_minigame: int = -2


# Perform final setup.
func _ready():
	# Populate the debug menu.
	var minigames = $Main/MinigameCanvas.Minigames
	$DebugMenu.populate_menu( minigames )

	# Override `debug_minigame` if the user requests it.
	var arguments: PoolStringArray = PoolStringArray(OS.get_cmdline_args())
	var length: int = arguments.size()
	var argument: int = 0
	var key: String
	var str_value: String
	var value: int
	var status: int = Arg_Debug_Minigame.SEARCHING
	while argument < length and status != Arg_Debug_Minigame.GOT_VALUE:
		key = arguments[argument]
		argument += 1
		if OS.is_debug_build():
			print("Got CMD argument %s." % key)
		# If the argument we're looking for is the actual value, rather than
		# the key, set `str_value` to the argument and then call it quits.
		if status == Arg_Debug_Minigame.GOT_KEY:
			str_value = key
			status = Arg_Debug_Minigame.GOT_VALUE
		else:
			# The specific argument we're looking for is "debug-minigame"
			if key.begins_with("--debug-minigame") \
			or key.begins_with("--debug_minigame"):
				# Determine if it was written in the format "--arg=value"
				if key.find("=") > -1:
					# If it was, split it up.
					var key_value: Array = key.split("=")
					str_value = key_value[1]
					status = Arg_Debug_Minigame.GOT_VALUE
				else:
					# If it wasn't, assume that the next argument will be the value
					# we need.
					status = Arg_Debug_Minigame.GOT_KEY

	var need_help: bool = false
	# If we got a possible value for the "debug-minigame" key, parse it now.
	if status == Arg_Debug_Minigame.GOT_VALUE:
		value = str_value.to_int()
		if value >= -1 and value < minigames.size():
			# If we got a valid minigame ID, set it and carry on.
			debug_minigame = value
		else:
			# If we got an invalid minigame ID, tell the user.
			var err = "Got invalid minigame ID %d (%s)." % [value, str_value]
			push_error(err)
			need_help = true
	elif status == Arg_Debug_Minigame.GOT_KEY:
		# If we got the key but not a value, assume the player wants help.
		need_help = true

	if need_help:
		$MainMenu/Menu/Buttons/DebugButton.show()
		value = minigames.size()
		var help_msg: String
		var title: String
		help_msg = "Here are the numeric IDs for the included minigames:"
		for game in range(value):
			title = $DebugMenu/VBoxContainer.get_child(game + 1).text
			help_msg += "\n%2d - %s" % [game, title]
		print(help_msg)
		get_tree().quit()

	if debug_minigame >= -1:
		print("Starting in debug mode for minigame %d." % debug_minigame)
		$MainMenu/Menu/Buttons/DebugButton.show()
		$MainMenu.hide()
		$Main.new_game(Global.GameMode.DEBUG, debug_minigame)


# Main has signalled game over.
func _on_Main_game_over( _result ):
	# Un-hide the main menu.
	$MainMenu.show()


# A button has been pressed on the main menu which requires Master's
# attention.
func _on_MainMenu_button_pressed( button ):
	match button:
		"new_game":
			_on_new_game()
		# Endurance Mode and Sudden Death are game modes 1 and 2.
		"endurance_mode":
			_on_new_game(Global.GameMode.ENDURANCE)
		"sudden_death":
			_on_new_game(Global.GameMode.SUDDEN_DEATH)
		"debug":
			_on_debug_menu()
		"quit":
			_on_quit()


# This function is used to handle the "new game" button being pressed.
# `mode` is the game mode being used.  Default is GameMode.NORMAL
func _on_new_game(mode = Global.GameMode.NORMAL):
	# Hide the main menu.
	$MainMenu.hide()
	# Start a new game.
	$Main.new_game( mode )


# This function is used to handle the debug menu button being pressed.
func _on_debug_menu():
	# Hide the main menu.
	$MainMenu.hide()
	# Show the debug menu.
	$DebugMenu.show()


# This function is used to handle the "quit" button being pressed.
func _on_quit():
	get_tree().quit()


# The "back" button has been pressed on the debug menu.  Go back to the main
# menu.
func _on_DebugMenu_debug_closed():
	$DebugMenu.hide()
	$MainMenu.show()


# A debug button has been pressed in the debug menu.
func _on_debug_button_pressed( id ):
	# Hide the debug menu.
	$DebugMenu.hide()
	# Start a new game in debug mode with the given minigame's ID number.
	$Main.new_game(Global.GameMode.DEBUG, id)
