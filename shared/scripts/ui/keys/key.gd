# `key.gd` - declares the `Key` class, used to provide a template for a
# generic blinking key icon in-game.


extends AnimatedSprite
class_name Key


# lights up the key by setting it to its default animation.
func light():
	animation = "default"
	start()


# dims the given key.
func dim():
	animation = "dim"
	start()


# causes the key to blink.
func blink():
	animation = "blink"
	start()


# causes the key to blink rapidly.
func blink_rapidly():
	animation = "blink_rapidly"
	start()
