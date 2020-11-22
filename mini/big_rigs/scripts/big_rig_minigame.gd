extends Minigame
# A script for the "Race that Rig!" minigame.


# Upon starting, enable movement in the rigs.
func start():
	_unlock_controls = true
	$RigPath/Rig1.allow_movement = true


# Rig1 has reached the end of the course and the player therefore wins.
func _on_Rig1_finished():
	emit_signal( "won" )
	$TextureRect.show()
