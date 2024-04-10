tool
extends Node2D
class_name Circle
# A node that renders as a circle.  Equivalent to `ColorRect` but designed for
# in-game display rather than UI display.


# The radius of the circle
export var _radius: float = 100.0 setget set_radius, get_radius

# The color of the circle
export var _color: Color = Color.white setget set_color, get_color


# Yes, this whole script exists literally just to draw a circle.  What of it?
func _draw():
	draw_circle(position, _radius, _color)


# Setter & getter for `_radius`.
func set_radius(new_radius: float):
	# A nonnegative radius is enforced.
	_radius = abs(new_radius)
	emit_signal("draw")

func get_radius() -> float:
	return _radius


# Setter & getter for `_color`.
func set_color(new_color: Color):
	_color = new_color
	emit_signal("draw")

func get_color() -> Color:
	return _color

# Alternative setters for `_color`.
func set_rgb(red: float, green: float, blue: float, alpha: float = 1.0):
	_color = Color(red, green, blue, alpha)
	emit_signal("draw")

func set_color_from_hex(hex: int):
	_color = Color(hex)
	emit_signal("draw")
