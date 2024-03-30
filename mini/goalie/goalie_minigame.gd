extends Minigame
# A minigame that doesn't in any way resemble Pong.


# Starts the minigame.
func start():
	$Goalie.unlock_movement = true
	$Kicker.start()
	$Ball.start()


# Stops the minigame.
func stop():
	$Goalie.unlock_movement = false
	$Kicker.unlock_movement = false
	$Ball.out_of_play = true


# The ball has passed the goal, and the player has lost.
func _on_Ball_passed_goal():
	stop()
	emit_signal("lost")


# The ball has moved out-of-bounds, triggering an early win.
func _on_Ball_out_of_bounds():
	stop()
	emit_signal("won")
