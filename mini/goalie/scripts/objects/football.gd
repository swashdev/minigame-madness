extends KinematicBody2D
# A ball threatening the goalie's turf.


# This signal is emitted when the ball reaches the goal.
signal passed_goal


# The ball's linear speed.
const BASE_SPEED: float = 400.0


# A boolean that unlocks movement.
var moving: bool = false

# This boolean is set to `true` when the ball has passed the goal or gone
# out-of-bounds, so that it doesn't spam the "passed_goal" signal.
var passed_goal: bool = false

# The ball's velocity.  This value is constant unless the ball has moved into
# the goal.
var velocity: Vector2 = Vector2(-BASE_SPEED, 0.0)


# The ball's physics process.
func _physics_process(delta):
	if moving:
		# Move the ball according to its `velocity`, checking for collisions
		# as we go.
		var collision: KinematicCollision2D = move_and_collide(velocity * delta,
				true)
		# Bounce off of anything we collide with.
		if collision:
			velocity = velocity.bounce(collision.normal)
	if passed_goal:
		# If the ball is has reached the goal, it will slow to a stop.
		velocity = velocity.move_toward(Vector2.ZERO, BASE_SPEED * delta)
	else:
		# If the ball moves past the goal, signal the game that the player
		# has lost.
		if position.x < 100.0:
			emit_signal("passed_goal")
			passed_goal = true


# How to draw the ball.  This function only really exists because Godot doesn't
# have a default node for drawing a circle.
#func _draw():
#	draw_circle(Vector2.ZERO, 10.0, Color.white)


# Starts the ball, having it pick a direction and then start moving.
func start():
	moving = true
