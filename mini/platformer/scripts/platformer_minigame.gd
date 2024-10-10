extends Minigame
# The "Lose!" minigame.


# Starting the "Lose!" minigame requires that we activate certain traps based
# on what the selected hazard was at initialization.
func start():
	$FluffyPlatformer.allow_movement = true


# Fluffy has been killed by an obstacle.
func _on_FluffyPlatformer_died():
	emit_signal( "lost" )
	$FluffyPlatformer.allow_movement = false


# Fluffy won the game.
func _on_FluffyPlatformer_won( cave: bool = false ):
	if cave:
		emit_signal( "found_secret" )
	else:
		emit_signal( "won" )
	$FluffyPlatformer.allow_movement = false
