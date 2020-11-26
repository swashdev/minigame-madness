extends Minigame
# A script for the shoot 'em up minigame


# Unlock the player's controls on starting the minigame.
func start():
	_unlock_controls = true
	$Player.allow_movement = true
