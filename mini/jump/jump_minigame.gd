extends Minigame
# A script for the "Jump!" minigame.


const GRAVITY: float = 1024.0
const JUMP_VELOCITY: float = 512.0


# The player's current velocity.
var velocity: Vector2 = Vector2.ZERO

# Whether or not the player is currently on a floor.
var grounded: bool = false


# The player character.
onready var player: KinematicBody2D = $Player


# The mainloop.
func _physics_process(delta):
	# The player is always pulled down due to gravity, even if the game isn't
	# running.
	velocity.y += GRAVITY * delta

	# If the controls have been unlocked, check to see if the player is
	# grounded and allow them to jump.
	if _unlock_controls:
		if grounded:
			if Input.is_action_just_pressed("action") \
			or Input.is_action_just_pressed("move_up"):
				velocity.y -= JUMP_VELOCITY
				print_debug("Jump button pressed!  Y velocity = " + str(velocity.y))

	# Move the player.
	velocity = player.move_and_slide(velocity, Vector2.UP)
	# Detect if the player is grounded.
	grounded = player.is_on_floor()
