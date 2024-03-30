extends Minigame
# A minigame that doesn't in any way resemble Pong.


# A scene representing a ball to be thrown at the player.
var ball: PackedScene = preload("res://mini/goalie/scenes/objects/ball.tscn")

# The spawn point for balls.  This is derived from the position of the first
# ball when the minigame is loaded.
var ball_spawn: Vector2

# Counts the number of balls we've spawned already so we don't throw too many
# at the player.
var ball_count: int = 1


func _ready():
	ball_spawn = Vector2($Ball.position)


# Starts the minigame.
func start():
	$Goalie.unlock_movement = true
	$Ball.start()
	$Timer.start()


# Stops the minigame.
func stop():
	$Goalie.unlock_movement = false
	$Timer.stop()


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
