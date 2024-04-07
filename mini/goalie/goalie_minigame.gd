extends Minigame
# A minigame that doesn't in any way resemble Pong.


# A scene representing a ball to be thrown at the player.
var ball: PackedScene = preload("res://mini/goalie/scenes/objects/football.tscn")

# Counts the number of balls we've spawned already so we don't throw too many
# at the player.
var ball_count: int = 0

# Keeps track of the angle that the last ball was thrown at.  The initial value
# is the angle of the first ball.
onready var ball_angle: float = rand_range(-0.5, 0.5)

# A spawn point for the balls, which also stores the ball nodes so that they
# draw behind the player.
onready var _spawner: Node2D = $Footballs


# Starts the minigame.
func start():
	$FootballPlayer.unlock_movement = true
	spawn_ball()
	$Timer.start()


# Stops the minigame.
func stop():
	$FootballPlayer.unlock_movement = false
	$Timer.stop()


# The ball has passed the goal, and the player has lost.
func _on_Ball_passed_goal():
	stop()
	emit_signal("lost")


func spawn_ball():
	var new_ball = ball.instance()
	new_ball.position = Vector2.ZERO
	new_ball.connect("passed_goal", self, "_on_Ball_passed_goal")

	# Rotate the ball.  The angle should be sharper for each ball in sequence.
	var r: float = rand_range(0.0, 0.35)
	if ball_angle < 0.0:
		ball_angle -= r
	else:
		ball_angle += r
	if randi() & 1:
		ball_angle *= -1
	new_ball.velocity = new_ball.velocity.rotated(ball_angle)

	_spawner.add_child(new_ball)
	new_ball.start()
	ball_count += 1


# The ball timer has gone off, so spawn a new ball.
func _on_Timer_timeout():
	spawn_ball()

	# If we've reached the maximum number of balls, stop spawning them.
	if ball_count >= 3:
		$Timer.stop()
