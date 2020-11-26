extends ColorRect
# A script for the stars in the starfield in the shoot 'em up game.


# The base speed of the star in pixels per second.
const BASE_SPEED: float = 400.0

# A modifier for the star's speed.
var _modifier: float = 1.0


# Initialize the star by choosing a color & speed modifier.
func _ready():
	_modifier = rand_range( 0.5, 1.0 )
	color = Color( _modifier, _modifier, _modifier, 1 )


# The mainloop for the star.  It basically just zips down the screen and then
# disappears.
func _process( delta ):
	rect_position.y += BASE_SPEED * _modifier * delta
	if rect_position.y > 480.0:
		queue_free()
