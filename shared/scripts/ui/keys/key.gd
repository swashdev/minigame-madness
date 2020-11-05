# `key.gd` - declares the `Key` class, used to provide a template for a
# generic blinking key icon in-game.


extends AnimatedSprite
class_name Key


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
