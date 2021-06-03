extends Minigame
# The main script for the "Put on Pants!" minigame.


func start():
	$PantsMan.allow_movement = true


func stop():
	$PantsMan.allow_movement = false
