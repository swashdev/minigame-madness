extends KinematicBody2D
# A script for the evil train from the "Dodge!" minigame.


# Emitted when the train crashes into the player.
signal crashed


const VELOCITY: Vector2 = Vector2(-400, 0)


# Stores whether or not the train has been released.
var _unlock_controls: bool = false setget unlock


# The mainloop: Moves the train along the track when it's released.
func _process( _delta ):
	if _unlock_controls:
		var collision = move_and_collide( VELOCITY * _delta )
		if collision:
			unlock( false )
			emit_signal( "crashed" )


# Unlocks the controls for the train.
func unlock( switch: bool = true ):
	_unlock_controls = switch
