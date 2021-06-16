extends KinematicBody2D
# A script for the duck from the "Get Across!" minigame.


# Defines the boundaries of the duck's movement.
enum { MIN_X = 22, MAX_X = 58 }

# The possible directions the duck could be moving.
enum { LEFT, RIGHT }

# The duck's movement speed.
const MOVE_SPEED: float = 38.0


# The direction the duck is currently moving.
var _direction: int = LEFT

# The duck's current movement vector.
var _movement: Vector2 = Vector2( 0, 0 )


# The duck's mainloop.  Causes it to move back and forth.
func _physics_process( _delta ):
	var move: float = 0.0
	if _direction == RIGHT:
		move = MOVE_SPEED
	else:
		move = -MOVE_SPEED

# warning-ignore:return_value_discarded
	move_and_slide( Vector2( move, 0 ) )

	# Check the duck's position.  If it is at the boundaries of its movement,
	# turn it around.
	if _direction == LEFT and position.x <= MIN_X:
		_direction = RIGHT
		$Sprite.flip_h = true
	elif _direction == RIGHT and position.x >= MAX_X:
		_direction = LEFT
		$Sprite.flip_h = false


# When the timer goes off, decide whether or not to quack.
func _on_Timer_timeout():
	# If the duck is already quacking, stop.
	if $Quack.visible:
		$Quack.hide()
	# Otherwise, flip a coin to decide whether to quack now.
	elif randi() & 1:
		$Quack.show()
