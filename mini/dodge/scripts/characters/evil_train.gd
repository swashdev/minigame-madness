extends KinematicBody2D
# A script for the evil train from the "Dodge!" minigame.


# Stores whether or not the train has been released.
var _unlock_controls: bool = false setget unlock


# The mainloop: Moves the train along the track when it's released.
func _process( delta ):
	if _unlock_controls:
		position.x -= 400 * delta


# Unlocks the controls for the train.
func unlock( switch: bool = true ):
	_unlock_controls = switch
