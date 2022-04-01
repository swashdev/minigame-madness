extends Sprite
# an arrow which can point in one of four directions and which changes color
# based on its direction.


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


# sets the arrow's direction.
func set_direction( direction: int ):
	if DEGREES.has( direction ):
		set_rotation_degrees( DEGREES[direction] )
	if PALETTE.has( direction ):
		set_modulate( PALETTE[direction] )

	# if we're in the editor, notify it that the property list has changed.
	if Engine.editor_hint:
		property_list_changed_notify()

