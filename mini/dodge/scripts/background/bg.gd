extends ParallaxBackground
# A script for the scrolling background in the "Dodge!" minigame.


# Determines whether or not the screen is currently scrolling.
var _scrolling: bool = true


# Scroll the background automagically.
func _process( delta ):
	if _scrolling:
		scroll_offset.x -= 300 * delta


# Stops the scrolling effect.
func stop_scrolling():
	_scrolling = false
