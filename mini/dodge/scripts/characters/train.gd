extends Area2D
# A script for the train from the "Dodge!" minigame.


# Represents what tracks the train might be on.
enum Track { TOP = 0, MIDDLE = 1, BOTTOM = 2 }


# The space between each track.
const MOVEMENT_SPEED: float = 300.0


# Stores whether or not controls for the train have been unlocked.
var _unlock_controls: bool = false setget unlock

# The mainloop: Moves the train up and down the tracks on player input.
func _process( _delta ):
	if _unlock_controls:
		var velocity = 0.0
		if Input.is_action_pressed( "move_up" ):
			velocity -= MOVEMENT_SPEED
		if Input.is_action_pressed( "move_down" ):
			velocity += MOVEMENT_SPEED
		position.y += velocity * _delta


# Unlocks the controls for the train.
func unlock( switch: bool = true ):
	_unlock_controls = switch
