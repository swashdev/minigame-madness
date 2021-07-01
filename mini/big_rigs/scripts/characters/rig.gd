extends PathFollow2D
# A script for the Rigs in the "Race that Rig!" minigame.


# A signal to indicate that the rig has reached the end of the course.
signal finished

# The max speed of the rig.
const MAX_SPEED: float = 100.0

var allow_movement: bool = false

# How quickly the rig is moving.
var _speed: float = 0.0

# The rate of acceleration per second.
var _acceleration: float = 3.0


# The mainloop for the rig.
func _process( delta ):
	if unit_offset == 1.0:
		# Emit the "finished" signal at the end of the path and disable
		# movement.
		emit_signal( "finished" )
		allow_movement = false
	if allow_movement:
		# Player input affects the rate at which the rig will move.
		if Input.is_action_pressed( "move_right" ):
			if _speed < MAX_SPEED:
				_speed += _acceleration * delta
		elif Input.is_action_pressed( "move_left" ):
			# Note there is no max speed while going backwards; this is
			# intentional.
			_speed -= _acceleration * delta
		else:
			# If the rig is currently moving forward, but there is no user
			# input, it will slow to a stop.  Note again that this doesn't
			# happen if the rig is moving backwards; this is also intentional.
			if _speed > 0.0:
				_speed -= _acceleration * delta
			else:
				_speed = 0.0

		# Move the rig according to its current speed.
		offset += _speed
