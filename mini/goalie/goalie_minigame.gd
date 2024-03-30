extends Minigame
# A minigame that doesn't in any way resemble Pong.


# Starts the minigame.
func start():
	$Goalie.unlock_movement = true
	$Ball.start()


# Stops the minigame.
func stop():
	$Goalie.unlock_movement = false


# The ball has passed the goal, and the player has lost.
func _on_Ball_passed_goal():
	stop()
	emit_signal("lost")


# The ball timer has gone off, so spawn a new ball.
func _on_Timer_timeout():
	var new_ball = ball.instance()
	new_ball.position = ball_spawn
	new_ball.connect("passed_goal", self, "_on_Ball_passed_goal")
	add_child(new_ball)
	new_ball.start()
	ball_count += 1

	# If we've reached the maximum number of balls, stop spawning them.
	if ball_count >= 3:
		$Timer.stop()
