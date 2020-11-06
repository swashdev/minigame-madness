# `instruction_label.gd`: Provides special functions for the Label in the
# in-game HUD.  Mostly used for animations.


extends Label


signal animation_finished


# Possible labels for the animation that the label is currently doing.
enum LabelAnimation \
{
	NONE,
	ZOOM_IN_FROM_RIGHT,
	ZOOM_OUT_LEFT,
}


# The label's current animation.
var current_animation = LabelAnimation.NONE


# The change in x per second when an animation is playing.
const MESSAGE_ZOOM_DX: int = 1280


# Triggers an animation in order to display a message.
func zoom_in_from_right( message = "your message here!" ):
	text = message
	rect_position.x = 640
	visible = true
	current_animation = LabelAnimation.ZOOM_IN_FROM_RIGHT


func _process(delta):
	if current_animation == LabelAnimation.ZOOM_IN_FROM_RIGHT:
		# The label will zoom in from the right, settling when its x value
		# reaches 0
		if rect_position.x >= MESSAGE_ZOOM_DX * delta:
			rect_position.x -= MESSAGE_ZOOM_DX * delta
		# When the label reaches the left side of the screen, snap the value
		# just in case we overshot and then start a timer to linger in this
		# position.
		else:
			rect_position.x = 0
			current_animation = LabelAnimation.NONE
			$MessageLingerTimer.start()
	elif current_animation == LabelAnimation.ZOOM_OUT_LEFT:
		# The label will zoom out to the left, stopping and becoming invisible
		# after it is fully off the screen.
		if rect_position.x > -640:
			rect_position.x -= MESSAGE_ZOOM_DX * delta
		else:
			visible = false
			current_animation = LabelAnimation.NONE
			emit_signal( "animation_finished" )


# A timer used to determine how long a message should remain on-screen before
# zooming off-screen.
func _on_MessageLingerTimer_timeout():
	current_animation = LabelAnimation.ZOOM_OUT_LEFT
