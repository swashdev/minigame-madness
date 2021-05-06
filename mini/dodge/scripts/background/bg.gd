extends ParallaxBackground


# Scroll the background automagically.
func _process( delta ):
	scroll_offset.x -= 300 * delta
