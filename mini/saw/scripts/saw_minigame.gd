extends Minigame
# A masher where you saw a log.


# How far the saw moves in pixels with each keypress.
const SAW_DX = 100
const SAW_DY = 5


# The process for this game is very simple: The player must alternate the left
# and right keys to keep the saw moving down until the log splits.
func _process( _delta ):
	# Check for player input.
	if _unlock_controls:
		if Input.is_action_pressed( "ui_left" ):
			# If the player hits a lit key, dim it and light the other, then
			# move the saw.
			if $Prompt/LeftKey.lit():
				$Prompt/LeftKey.dim()
				$Prompt/RightKey.light()
				$Saw.position.x -= SAW_DX
				$Saw.position.y += SAW_DY
		elif Input.is_action_pressed( "ui_right" ):
			if $Prompt/RightKey.lit():
				$Prompt/RightKey.dim()
				$Prompt/LeftKey.light()
				$Saw.position.x += SAW_DX
				$Saw.position.y += SAW_DY

	# Check if the saw has reached a certain target travel distance.  If it
	# has, signal victory and lock the controls; we're done.
	if $Saw.position.y >= $Target.position.y:
		_unlock_controls = false
		emit_signal( "won" )
