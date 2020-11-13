extends Minigame
# A masher where you saw a log.


# How far the saw moves in pixels with each keypress.
const SAW_DX = 50
const SAW_DY = 2

# Constants relevant to the falling logs animation.
const LOG_DX = 100
const LOG_DY = 400
const LOG_DR = 180

# Whether or not to animate the logs falling.
var _logs_fall_everyone_dies : bool = false


# The process for this game is very simple: The player must alternate the left
# and right keys to keep the saw moving down until the log splits.
func _process( delta ):
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

		# Check if the saw has reached a certain target travel distance.  If
		# it has, signal victory and lock the controls; we're done.
		if $Saw.position.y >= $Target.position.y:
			_unlock_controls = false
			$SeamCover.set_visible( false )
			_logs_fall_everyone_dies = true
			emit_signal( "won" )

	# Animate the logs falling away.
	if _logs_fall_everyone_dies:
		$LogFore.position.x += LOG_DX * delta
		$LogFore.position.y += LOG_DY * delta
		$LogFore.rotation_degrees += LOG_DR * delta
		$LogAft.position.x -= LOG_DX * delta
		$LogAft.position.y += LOG_DY * delta
		$LogAft.rotation_degrees -= LOG_DR * delta


# Begin the minigame.
func start():
	_unlock_controls = true
	# Randomly select a key to illuminate.
	if randi() % 2 == 0:
		$Prompt/RightKey.light()
		$Saw.position.x -= SAW_DX
	else:
		$Prompt/LeftKey.light()
