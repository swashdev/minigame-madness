extends Area2D
# A script for the falling spike in the "Lose" minigame.


# The spike's gravitational acceleration.
const GRAVITY: float = 60.0

# Whether or not the spike is sleeping.
var _sleeping: bool = true

# The spike's current velocity.
var _velocity: float = 0.0


# If the spike is awake, it will begin to fall through the level.
func _physics_process( delta ):
	if !_sleeping:
		_velocity += GRAVITY * delta
		position.y += _velocity


# The spike has struck Fluffy and kills him.
func _on_Spike_body_entered( body ):
	body.die()


# The timer has gone off, causing the spike to start falling.
func _on_Timer_timeout():
	_sleeping = false


# The spike has left the screen and can be dequeued.
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
