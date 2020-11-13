extends AnimatedSprite
# A script for the pitcher from the "Hit a Home Run!" game.


# Signals the baseball game that the pitcher has thrown the ball.
signal threw_ball

# Determines the maximum number of times the pitcher can delay before he is
# forced to throw the pitch.
var MAX_DELAYS: int = 2

# Determines how many times the pitcher has delayed.
var _num_delays: int = 0


# Throw the ball.
func _pitch():
	$Timer.stop()
	animation = "pitch"
	play()
	yield( self, "animation_finished" )
	emit_signal( "threw_ball" )


# Put off throwing the ball.
func _stall():
	# Increment the delay counter.
	_num_delays = _num_delays + 1
	animation = "stall"
	play()


# Decide whether to delay or to throw the ball.
func _on_Timer_timeout():
	if _num_delays >= MAX_DELAYS:
		_pitch()
	else:
		if randi() % 2 == 0:
			_pitch()
		else:
			_stall()
