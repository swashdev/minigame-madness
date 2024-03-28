tool
extends Control
# A cool nighttime backdrop with a random star pattern.


# The number of stars to draw in the sky.  Must be non-negative.
export var num_stars = 1024 setget set_num_stars

# The minimum & maximum brightness of each star.
export(float, 0.1, 1.0, 0.05) var min_brightness = 0.25 setget set_min_brightness
export(float, 0.1, 1.0, 0.05) var max_brightness = 1.0 setget set_max_brightness


# The `draw` function.  A virtual function used by the engine to draw the sky.
func _draw():
# warning-ignore:narrowing_conversion
	var top: int = margin_top
# warning-ignore:narrowing_conversion
	var left: int = margin_left
# warning-ignore:narrowing_conversion
	var right: int = margin_right
# warning-ignore:narrowing_conversion
	var bottom: int = margin_bottom

	# Start with a black background.
	draw_rect(Rect2(top, left, right, bottom), Color.black, true)

	# Randomly assign each star an `x` & `y` coordinat, and an `i`ntensity.
	var x: int
	var y: int
	var i: float
	var count: int = 0
	while count < num_stars:
		x = left + (randi() % (right - left))
		y = top + (randi() % (bottom - top))
		i = rand_range(min_brightness, max_brightness)
		draw_rect(Rect2(x, y, 1, 1), Color.white * i, true)
		count += 1


# Setters & getters.  Note that any of these will cause the sky to be wholly
# redrawn.

func set_num_stars(new_num_stars: int):
	if new_num_stars >= 0:
		num_stars = new_num_stars
	else:
		num_stars = 0
	emit_signal("draw")


func set_min_brightness(new_min_brightness: float):
	min_brightness = new_min_brightness
	if new_min_brightness > max_brightness:
		max_brightness = new_min_brightness
	emit_signal("draw")


func set_max_brightness(new_max_brightness: float):
	max_brightness = new_max_brightness
	if new_max_brightness < min_brightness:
		min_brightness = new_max_brightness
	emit_signal("draw")
