extends KinematicBody2D
# A goalie for the soccer game.


const BASE_SPEED: int = 200


# A ball for the kicker to try to kick back.
var ball: Node


var unlock_movement: bool = false


# The kicker's main process.
func _physics_process(delta):
	if unlock_movement:
		# Check the kicker's movement against the ball's.
		var ball_pos: Vector2 = ball.position
		var y_diff: float = ball_pos.y - position.y
		var movement: float
		if y_diff < 0.0:
			movement = -(delta)
		elif y_diff > 0.0:
			movement = delta
		movement *= BASE_SPEED
		# If the difference in position is too small to matter, just snap to the
		# ball's position.
		if abs(y_diff) < abs(movement):
			position.y = ball_pos.y
		else:
			position.y += movement
		if position.y < 50.0:
			position.y = 50.0
		elif position.y > 420.0:
			position.y = 420.0


# Activates the kicker.
func start():
	# Try to grab the `ball`.
	ball = get_node("../Ball")
	if not ball:
		# If we didn't get a ball, push an error message.
		OS.alert("Kicker couldn't find a ball!", "Bad code detected!")
	else:
		# If we did get a ball, activate movement.
		unlock_movement = true
