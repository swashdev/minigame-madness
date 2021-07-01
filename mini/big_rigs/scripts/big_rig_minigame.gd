extends Minigame
# A script for the "Race that Rig!" minigame.


# Mainloop for the minigame.  Moves the second player rig.
func _process( delta ):
	if _unlock_controls:
		if $RigPath/Rig2.unit_offset < 1.0:
			$RigPath/Rig2.unit_offset += 0.25 * delta


# Upon starting, enable movement in the rigs.
func start():
	_unlock_controls = true
	$RigPath/Rig1.allow_movement = true


# Rig1 has reached the end of the course and the player therefore wins.
func _on_Rig1_finished():
	emit_signal( "won" )
	_unlock_controls = false
	$TextureRect.show()
