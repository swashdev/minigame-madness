extends Minigame
# A script for the "Get Across!" minigame.


# Unlock the player's controls when the minigame starts.
func start():
	$IndianaJumpman.unlock()
	
	
# Lock the player's controls when the minigame finishes.
func stop():
	$IndianaJumpman.lock()


# The player has died in some way, meaning they lose the minigame.
func _on_IndianaJumpman_died():
	stop()
	emit_signal( "lost" )


# The win zone has detected a body entering.  Since the player is the only
# body it scans for, this immediately triggers a victory.
func _on_WinZone_body_entered( _body ):
	stop()
	emit_signal( "won" )
