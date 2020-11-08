class_name KeyPrompt
extends AnimatedSprite
# A template for an on-screen prompt to press a key, with built-in animations
# to light, dim, or blink the key appropriately.


func animate( which_animation ):
	animation = which_animation
	play()


# lights up the key by setting it to its default animation.
func light():
	animate( "default" )


# dims the given key.
func dim():
	animate( "dim" )


# causes the key to blink.
func blink():
	animate( "blink" )


# causes the key to blink rapidly.
func blink_rapidly():
	animate( "blink_rapidly" )


# returns whether the prompt is lit
func lit() -> bool:
	return animation == "default"


# returns whether the prompt is blinking
func blinking() -> bool:
	return animation == "blink" or animation == "blink_rapidly"
