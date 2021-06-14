extends Minigame
# A script for the "Get Across!" minigame.


# The player has died in some way, meaning they lose the minigame.
func _on_IndianaJumpman_died():
	_unlock_controls = false
	emit_signal( "lost" )


# The win zone has detected a body entering.  Since the player is the only
# body it scans for, this immediately triggers a victory.
func _on_WinZone_body_entered( _body ):
	_unlock_controls = false
	emit_signal( "won" )
