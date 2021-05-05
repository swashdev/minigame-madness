extends Area2D
# A script for the train from the "Dodge!" minigame.


# Represents what tracks the train might be on.
enum Track { TOP = 0, MIDDLE = 1, BOTTOM = 2 }


# The space between each track.
const TRACK_SPACE: float = 112.0


# Stores whether or not controls for the train have been unlocked.
var _unlock_controls: bool = false setget unlock

# Stores which track the train is currently on.
var current_track: int = Track.MIDDLE


# The mainloop: Moves the train up and down the tracks on player input.
func _process( _delta ):
	if _unlock_controls:
		if Input.is_action_just_pressed( "move_up" ):
			if current_track > Track.TOP:
				current_track -= 1
				position.y -= TRACK_SPACE
		elif Input.is_action_just_pressed( "move_down" ):
			if current_track < Track.BOTTOM:
				current_track += 1
				position.y += TRACK_SPACE


# Unlocks the controls for the train.
func unlock( switch: bool = true ):
	_unlock_controls = switch
