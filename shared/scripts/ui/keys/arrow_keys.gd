# `arrow_keys.gd`: provides scripting for the ArrowKeys UI element to make it
# easier to blink particular keys, &c


extends Node2D
class_name ArrowKeys


# instructs the given arrow to do a certain animation.  if `which_key` is
# "all," apply the animation to all of the keys.
func animate_key( which_animation, which_key = "all" ):
	if which_key == "all" or which_key == "up":
		$UpKey.animate( which_animation )
	if which_key == "all" or which_key == "down":
		$DownKey.animate( which_animation )
	if which_key == "all" or which_key == "right":
		$RightKey.animate( which_animation )
	if which_key == "all" or which_key == "left":
		$LeftKey.animate( which_animation )


# lights up the given key by setting it to its default animation, or all of
# the keys, as appropriate.
func light( which_key = "all" ):
	animate_key( "default", which_key )


# dims the given key, or all of them, as appropriate.
func dim( which_key = "all" ):
	animate_key( "dim", which_key )


# causes the given key to blink, or all of them, as appropriate.
func blink( which_key = "all" ):
	animate_key( "blink", which_key )


# causes the given key to blink rapidly, or all of them, as appropriate.
func blink_rapidly( which_key = "all" ):
	animate_key( "blink_rapidly", which_key )
