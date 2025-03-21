extends Area2D
# A script for the falling spike in the "Lose" minigame.


# The spike's gravitational acceleration.
const GRAVITY: float = 60.0

# The spike's sprite.
onready var _sprite: Sprite = $Sprite

# Whether or not the spike is sleeping.
var _sleeping: bool = true

# The spike's current velocity.
var _velocity: float = 0.0


# If the spike is awake, it will begin to fall through the level.
func _physics_process( delta ):
	if !_sleeping:
		_velocity += GRAVITY * delta
		position.y += _velocity
		# Stop moving when the spike is well off the screen.
		if position.y >= 580.0:
			_sleeping = true


func _shake():
	# If the spike is currently shaking, offset the sprite alternatingly:
	if _sprite.position.x < 0.0:
		_sprite.position.x = 2.0
	else:
		_sprite.position.x = -2.0



# The spike has struck Fluffy and kills him.
func _on_Spike_body_entered( body ):
	body.die()


# The timer has gone off, causing the spike to start falling.
func _on_Timer_timeout():
	_sprite.position.x = 0.0
	_sleeping = false


# The spike has left the screen and can be dequeued.
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
