tool
extends Sprite
# an arrow which can point in one of four directions and which changes color
# based on its direction.


# A signal informing the minigame that the arrow has despawned, either because
# of a miss or a hit, and providing the `score` resulting from the despawn.
# Anything higher than 0 is a hit.
signal despawned( score )


# Possible values for `score` in the "despawned" signal.
enum { MISS, OK, GOOD, GREAT, PERFECT }


# Valid directions for the arrow to point.
enum { UP, DOWN, LEFT, RIGHT }


# Colors the arrow can be, based on what direction it's pointing.
const PALETTE: Dictionary = \
{
	UP: Color.green,
	RIGHT: Color.red,
	DOWN: Color.orange,
	LEFT: Color.blue,
}


# Rotations the arrow may have, based on the direction it's pointing.
const DEGREES: Dictionary = \
{
	UP: 0.0,
	RIGHT: 90.0,
	DOWN: 180.0,
	LEFT: 270.0,
}


# Actions which might cause the arrow to trigger, based on its direction.
const TRIGGERS: Dictionary = \
{
	UP: "move_up",
	RIGHT: "move_right",
	DOWN: "move_down",
	LEFT: "move_left",
}


const FALL_SPEED: float = 600.0


# Determines what direction the arrow is pointing.
export(int, "Up", "Down", "Left", "Right") onready var _direction: int = 0 \
		setget set_direction, get_direction


# Mainloop for the dance arrows.
func _process( delta ):
	var distance = position.y
	# if the arrow has fallen below the edge of the screen, remove it.
	if distance > 540:
		despawn( MISS )
	else:
		position.y += FALL_SPEED * delta

	# if the arrow's trigger has been pressed, delet.
	if Input.is_action_just_pressed( TRIGGERS[_direction] ):
		# If the arrow isn't anywhere near the target, just ignore the input.
		if distance > 340:
			# Calculate the player's accuracy from the arrow's distance to the
			# target.
			var error: float = abs( 400.0 - distance )

			# Assign more points for a lower `error`.
			if error <= 1:
				despawn( PERFECT )
			elif error <= 10:
				despawn( GREAT )
			elif error <= 20:
				despawn( GOOD )
			elif error <= 30:
				despawn( OK )
			else:
				despawn( MISS )

# Despawns the arrow and provides a resulting score.
func despawn( score: int ):
	emit_signal( "despawned", score )
	queue_free()


# sets the arrow's direction.
func set_direction( direction: int ):
	_direction = direction
	if DEGREES.has( direction ):
		set_rotation_degrees( DEGREES[direction] )
	if PALETTE.has( direction ):
		set_modulate( PALETTE[direction] )

	# if we're in the editor, notify it that the property list has changed.
	if Engine.editor_hint:
		property_list_changed_notify()


func get_direction() -> int:
	return _direction
