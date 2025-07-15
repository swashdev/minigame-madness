tool
class_name SkyBackground
extends Node2D
# A generic class used by Minigame Madness for background objects which
# represent the sky.


const DEFAULT_WIDTH: float = 640.0
const DEFAULT_HEIGHT: float = 480.0


var texture: Texture


var size: Vector2 = Vector2(DEFAULT_WIDTH, DEFAULT_HEIGHT)


func _draw():
	if not texture:
		# If there is no texture, fill in a black box.
		draw_rect(Rect2(position, size), \
				Color.black, true)
	else:
		# Draw the imported texture.
		draw_texture(texture, position)


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
		"x", "rect_left":
			position.x = value
		"y", "rect_top":
			position.y = value
		"height":
			size.y = value
		"width":
			size.x = value
		"rect_bottom":
			position.y = (value - size.y)
		"rect_right":
			position.x = (value - size.x)
		"size":
			size = value
		"texture":
			texture = value
		_:
			# In the default case, return false.
			result = false

	if Engine.editor_hint:
		if result:
			property_list_changed_notify()

	return result


func _get_property_list():
	return [
		{
			name = "Background",
			type = TYPE_NIL,
			usage = PROPERTY_USAGE_CATEGORY | PROPERTY_USAGE_SCRIPT_VARIABLE,
		},
		{
			name = "texture",
			type = TYPE_OBJECT,
			hint = PROPERTY_HINT_RESOURCE_TYPE,
			hint_string = "Texture",
		},
		# Properties for the bounding box
		{
			name = "Dimensions",
			type = TYPE_NIL,
			usage = PROPERTY_USAGE_CATEGORY | PROPERTY_USAGE_SCRIPT_VARIABLE,
		},
		{
			name = "size",
			type = TYPE_VECTOR2,
		},
		{
			name = "Rect",
			type = TYPE_NIL,
			hint_string = "rect_",
			usage = PROPERTY_USAGE_GROUP | PROPERTY_USAGE_SCRIPT_VARIABLE,
		},
		{
			name = "rect_top",
			type = TYPE_REAL,
			usage = PROPERTY_USAGE_EDITOR,
		},
		{
			name = "rect_bottom",
			type = TYPE_REAL,
			usage = PROPERTY_USAGE_EDITOR,
		},
		{
			name = "rect_left",
			type = TYPE_REAL,
			usage = PROPERTY_USAGE_EDITOR,
		},
		{
			name = "rect_right",
			type = TYPE_REAL,
			usage = PROPERTY_USAGE_EDITOR,
		},
	]


func property_can_revert(property: String) -> bool:
	match property:
		"x", "y", "height", "width", "size", "texture", \
		"rect_top", "rect_left", "rect_bottom", "rect_right":
			return true
		_:
			return false


func property_get_revert(property: String):
	match property:
		"x", "y", "rect_top", "rect_left":
			return 0.0
		"width":
			return DEFAULT_WIDTH
		"height":
			return DEFAULT_HEIGHT
		"rect_bottom":
			return position.y + DEFAULT_HEIGHT
		"rect_right":
			return position.x + DEFAULT_WIDTH
		"size":
			return Vector2(DEFAULT_WIDTH, DEFAULT_HEIGHT)
		_:
			return null
