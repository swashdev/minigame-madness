tool
class_name NightSkyBackground
extends SkyBackground
# A cool nighttime backdrop with a random star pattern.


# The number of stars to draw in the sky.  Must be non-negative.
var num_stars: int = 1024

# The minimum & maximum brightness of each star.
var brightness_min: float = 0.25
var brightness_max: float = 1.0


# The `draw` function.  A virtual function used by the engine to draw the sky.
func _draw():
	# Randomly assign each star an `x` & `y` coordinat, and an `i`ntensity.
	var x: float
	var y: float
	var i: float
	var count: int = 0
	while count < num_stars:
		x = rand_range(position.x, position.x + size.x)
		y = rand_range(position.y, position.y + size.y)
		i = rand_range(brightness_min, brightness_max)
		draw_rect(Rect2(x, y, 1, 1), Color.white * i, true)
		count += 1


# Getter for custom properties
func _get(property: String):
	var result

	match property:
		"x", "rect_left":
			result = position.x
		"y", "rect_top":
			result = position.y
		"height":
			result = size.y
		"width":
			result = size.x
		"rect_bottom":
			result = position.y + size.y
		"rect_right":
			result = position.x + size.x
		_:
			result = null

	return result


# Setter for custom properties
func _set(property: String, value) -> bool:
	var result: bool = true

	match property:
		"num_stars":
			num_stars = value
		"brightness_min":
			if value >= 0.1:
				brightness_min = value
				if brightness_max < value:
					brightness_max = value
		"brightness_max":
			if value >= 0.1:
				brightness_max = value
				if brightness_min > value:
					brightness_min = value
		_:
			# In the default case, return false.
			result = false

	if result:
		if Engine.editor_hint:
			property_list_changed_notify()

	return result


func _get_property_list():
	return [
		{
			name = "Stars",
			type = TYPE_NIL,
			usage = PROPERTY_USAGE_CATEGORY | PROPERTY_USAGE_SCRIPT_VARIABLE,
		},
		{
			name = "num_stars",
			type = TYPE_INT,
			hint = PROPERTY_HINT_RANGE,
			hint_string = "0,65535,or_greater",
		},
		{
			name = "Brightness",
			type = TYPE_NIL,
			hint_string = "brightness_",
			usage = PROPERTY_USAGE_GROUP | PROPERTY_USAGE_SCRIPT_VARIABLE,
		},
		{
			name = "brightness_min",
			type = TYPE_REAL,
			hint = PROPERTY_HINT_RANGE,
			hint_string = "0.1,1.0,0.05",
		},
		{
			name = "brightness_max",
			type = TYPE_REAL,
			hint = PROPERTY_HINT_RANGE,
			hint_string = "0.1,1.0,0.05",
		},
	]


func property_can_revert(property: String) -> bool:
	match property:
		"num_stars", "brightness_min", "brightness_max":
			return true
		_:
			return .property_can_revert(property)


func property_get_revert(property: String):
	match property:
		"num_stars":
			return 1024
		"brightness_min":
			return 0.25
		"brightness_max":
			return 1.0
		_:
			return .property_get_revert(property)

