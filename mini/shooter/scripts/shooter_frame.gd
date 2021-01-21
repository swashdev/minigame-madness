extends Minigame
# A script for the frame around the shooter minigame.


# Since the ShooterFrame functions as a frame around the actual minigame, this
# script pretty much defers everything to the ShooterMinigame.

# Gameloop.  Pretty much just updates the kill counter.
func _process( _delta ):
	$KillCounter.text = "Kills: %d" % $Minigame.get_kills()


func decide():
	$Minigame.decide()


func start():
	$Minigame.start()


func stop():
	$Minigame.stop()


func _on_Minigame_won():
	emit_signal( "won" )


func _on_Minigame_lost():
	emit_signal( "lost" )


# The player has deployed their missile, so we dim the missile key to let the
# player know that was their one shot.
func _on_Minigame_missile_deployed():
	$MissileKey.dim()
