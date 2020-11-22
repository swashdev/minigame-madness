extends Minigame
# A script for the "Slice that 'Za!" minigame.


# The margin of error for the slicer's rotation during slicing.
const MARGIN_OF_ERROR: float = 5.0

# Used to store whether or not the 'za is fully sliced.
var _sliced: bool = false

# Used to store the number of successful slices.
var _slices: int = 0


# For testing.
func _ready():
	start()
# The mainloop for the minigame.
func _process( _delta ):
	if _unlock_controls:
		if Input.is_action_just_pressed( "action" ):
			try_slice()


# Starts the minigame by unlocking the controls.
func start():
	$SliceGuide.show()
	$Slicer.allow_movement = true
	_unlock_controls = true


# Stops the minigame by locking the controls & hiding unsightly sprites.
func stop():
	_unlock_controls = false
	$Slicer.allow_movement = false
	$Slicer/Guideline.hide()
	$SliceGuide.hide()


# Tries to slice the 'za based on the slicer's current position.
func try_slice():
	# A slice is successful if the slicer is within the tolerance level of
	# the guide's rotation.
	var slicer_rot = wrapf( $Slicer.rotation_degrees,
			-MARGIN_OF_ERROR, 180.0 - MARGIN_OF_ERROR )
	var guider_rot = wrapf( $SliceGuide.rotation_degrees,
			-MARGIN_OF_ERROR, 180.0 - MARGIN_OF_ERROR )
	# If the player is not within the margin of error, they lose.
	if slicer_rot < (guider_rot - MARGIN_OF_ERROR) \
	or slicer_rot > (guider_rot + MARGIN_OF_ERROR):
		decide()
	# If they are, the slice is done and the guide repositioned.
	else:
		_slices += 1
		$Za.slice()
		do_next_position()


# Move the SliceGuide into the next position.
func do_next_position():
	match _slices:
		0:
			$SliceGuide.rotation_degrees = 0.0
		1:
			$SliceGuide.rotation_degrees = 90.0
		2:
			$SliceGuide.rotation_degrees = 135.0
		3:
			$SliceGuide.rotation_degrees = 45.0
		_:
			stop()


# Decide whether the player has won the minigame.
# In this minigame, if the player has not already been declared the winner by
# the time the timer expires, they will be declared the winner ONLY if they
# have fully sliced the 'za.
func decide():
	stop()
	if _sliced:
		emit_signal( "won" )
	else:
		emit_signal( "lost" )


# The 'za has been sliced; make a note of that.
func _on_Za_sliced():
	stop()
	_sliced = true


# The 'za has been eaten; declare the player victorious.
func _on_Za_eaten():
	emit_signal( "won" )
