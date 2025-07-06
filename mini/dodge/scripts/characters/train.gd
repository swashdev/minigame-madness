extends KinematicBody2D
# A script for the train from the "Dodge!" minigame.


# Emitted if the player crashes.
signal crashed


# Represents what tracks the train might be on.
enum Track { TOP = 0, MIDDLE = 1, BOTTOM = 2 }


# The space between each track.
const MOVEMENT_SPEED: float = 300.0


# Stores whether or not controls for the train have been unlocked.
var _unlock_controls: bool = false setget unlock

# The mainloop: Moves the train up and down the tracks on player input.
func _process( _delta ):
	if _unlock_controls:
		var velocity: Vector2 = Vector2.ZERO
		if Input.is_action_pressed( "move_up" ):
			velocity.y -= MOVEMENT_SPEED
		if Input.is_action_pressed( "move_down" ):
			velocity.y += MOVEMENT_SPEED
		var collision = move_and_collide( velocity * _delta )
		if collision:
			var body = collision.collider
			# Only fail the minigame if the body has a signal (we use this to
			# differentiate the cars from the boundaries of the road)
			if body.has_signal( "crashed" ):
				emit_signal( "crashed" )
				body.unlock( false )


# Unlocks the controls for the train.
func unlock( switch: bool = true ):
	_unlock_controls = switch
