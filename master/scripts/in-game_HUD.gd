class_name InGameHUD
extends Control
# The in-game HUD for Minigame Madness.


signal message_exited


func show_life_counter():
	$LifeCounter.visible = false


func hide_life_counter():
	$LifeCounter.visible = false


# Update the life counter's text to reflect the new number of lives, 5 by
# default.
func update_life_counter( lives = 5 ):
	$LifeCounter.text = "Lives: %d" % lives


func show_progress_bar():
	$LifeCounter.visible = false


func hide_progress_bar():
	$TimerProgress.visible = false


# Fill or drain the timer progress bar to the appropriate level.
func update_progress_bar( value ):
	$TimerProgress.value = value


# Display a given message using an animation defined in the `InstructionLabel`
# script and then signal when the message is off-screen.
func message( text ):
	$InstructionLabel.zoom_in_from_right( text )
	yield( $InstructionLabel, "animation_finished" )
	emit_signal( "message_exited" )