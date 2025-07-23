extends KinematicBody2D
# A script for the duck from the "Get Across!" minigame.


# Defines the boundaries of the duck's movement.
enum { MIN_X = 22, MAX_X = 58 }

# The possible directions the duck could be moving.
enum { LEFT, RIGHT }

# The duck's movement speed.
const MOVE_SPEED: float = 22.5


# The direction the duck is currently moving.
var _direction: int = RIGHT

# The duck's current movement vector.
var _movement: Vector2 = Vector2( 0, 0 )


onready var _sprite = $Sprite
onready var _quack = $Quack


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
		_sprite.flip_h = true
		_sprite.position.x += 1
	elif _direction == RIGHT and position.x >= MAX_X:
		_direction = LEFT
		_sprite.flip_h = false
		_sprite.position.x -= 1


# When the timer goes off, decide whether or not to quack.
func _on_Timer_timeout():
	# If the duck is already quacking, stop.
	if _quack.visible:
		_quack.hide()
	# Otherwise, flip a coin to decide whether to quack now.
	elif randi() & 1:
		_quack.show()
