extends Label
# A label used to display instructions and other messages in Minigame Madness.


signal animation_finished

# Possible labels for the animation that the label is currently doing.
enum LabelAnimation \
{
	NONE,
	ZOOM_IN_FROM_RIGHT,
	ZOOM_IN_FROM_BOTTOM,
	ZOOM_OUT_LEFT,
	ZOOM_OUT_TOP,
}

# The change in x per second when a horizontal "zoom" animation is playing.
const MESSAGE_ZOOM_DX: int = 1280
# The change in y per second when a vertical "zoom" animation is playing.
const MESSAGE_ZOOM_DY: int = 960
# The x value for which the message will be considered to be "centered"
const MESSAGE_CENTER_X: int = 0
# The y value for same.
const MESSAGE_CENTER_Y: int = 213

# The label's current animation.
var _current_animation = LabelAnimation.NONE
# How long the message will stay on-screen before the animation proceeds.
var _message_linger: float = 0.5


func _process(delta):
	if _current_animation == LabelAnimation.ZOOM_IN_FROM_RIGHT:
		# The label will zoom in from the right, settling when its x value
		# reaches 0
		if rect_position.x - MESSAGE_CENTER_X >= MESSAGE_ZOOM_DX * delta:
			rect_position.x -= MESSAGE_ZOOM_DX * delta
		# When the label reaches the left side of the screen, snap the value
		# just in case we overshot and then start a timer to linger in this
		# position.
		else:
			rect_position.x = MESSAGE_CENTER_X
			_current_animation = LabelAnimation.NONE
			# Linger for a moment and then set the animation to ZOOM_OUT_LEFT.
			yield( get_tree().create_timer( _message_linger ), "timeout" )
			_current_animation = LabelAnimation.ZOOM_OUT_LEFT
	elif _current_animation == LabelAnimation.ZOOM_OUT_LEFT:
		# The label will zoom out to the left, stopping and becoming invisible
		# after it is fully off the screen.
		if rect_position.x > -1 * rect_size.x:
			rect_position.x -= MESSAGE_ZOOM_DX * delta
		else:
			visible = false
			_current_animation = LabelAnimation.NONE
			emit_signal( "animation_finished" )

	elif _current_animation == LabelAnimation.ZOOM_IN_FROM_BOTTOM:
		if rect_position.y - MESSAGE_CENTER_Y >= MESSAGE_ZOOM_DY * delta:
			rect_position.y -= MESSAGE_ZOOM_DY * delta
		else:
			rect_position.y = MESSAGE_CENTER_Y
			_current_animation = LabelAnimation.NONE
			# Linger for a moment and then set thte animation to ZOOM_OUT_TOP
			yield( get_tree().create_timer( _message_linger ), "timeout" )
			_current_animation = LabelAnimation.ZOOM_OUT_TOP
	elif _current_animation == LabelAnimation.ZOOM_OUT_TOP:
		if rect_position.y > -1 * rect_size.y:
			rect_position.y -= MESSAGE_ZOOM_DY * delta
		else:
			visible = false
			_current_animation = LabelAnimation.NONE
			emit_signal( "animation_finished" )


# Causes a message to zoom in from the right of the screen and then exit
# to the left.
func zoom_in_from_right( message = "your message here!", time = 0.5 ):
	text = message
	rect_position.x = 640
	rect_position.y = MESSAGE_CENTER_Y
	visible = true
	_current_animation = LabelAnimation.ZOOM_IN_FROM_RIGHT
	_message_linger = time


# Causes a message to zoom in from the bottom of the screen and then exit
# through the top.
func zoom_in_from_bottom( message = "your message here!", time = 0.5 ):
	text = message
	rect_position.y = 480
	rect_position.x = MESSAGE_CENTER_X
	visible = true
	_current_animation = LabelAnimation.ZOOM_IN_FROM_BOTTOM
	_message_linger = time
