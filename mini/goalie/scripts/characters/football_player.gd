extends KinematicBody2D
# A goalie for the soccer game.


const BASE_SPEED: int = 700


var unlock_movement: bool = false


# The goalie's main process.
func _physics_process(delta):
	if unlock_movement:
		# Figure out if we're moving in this frame.
		var up_strength: float = Input.get_action_strength("move_up")
		var down_strength: float = Input.get_action_strength("move_down")
		var speed = down_strength - up_strength

		# Move the goalie.
		position.y += speed * BASE_SPEED * delta
		# Constrain the goalie's movement.
		if position.y < 50.0:
			position.y = 50.0
		elif position.y > 410.0:
			position.y = 410.0
