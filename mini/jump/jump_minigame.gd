extends Minigame
# A script for the "Jump!" minigame.


const GRAVITY: float = 2048.0
const JUMP_VELOCITY: float = 768.0
const PUSHER_VELOCITY: Vector2 = Vector2(-320.0, 0.0)


# The player's current velocity.
var velocity: Vector2 = Vector2.ZERO

# Whether or not the player is currently on a floor.
var grounded: bool = false


# The player character.
onready var player: KinematicBody2D = $Player

# The pushers (obstacles)
onready var pushers: Array = $Pushers.get_children()


# The mainloop.
func _physics_process(delta):
	var collision: KinematicCollision2D
	var remainder: Vector2

	# The player is always pulled down due to gravity, even if the game isn't
	# running.
	velocity.y += GRAVITY * delta
	velocity.x = 0.0

	if _unlock_controls:
		# If the  player is grounded, allow them to jump.
		if grounded:
			if Input.is_action_just_pressed("action") \
			or Input.is_action_just_pressed("move_up"):
				velocity.y -= JUMP_VELOCITY

		# Advance the pushers.
		for pusher in pushers:
			collision = pusher.move_and_collide(PUSHER_VELOCITY * delta)
			if collision:
				# If the pusher collides with the player, push the player
				# along.  Also, finish the pusher's own movement to keep the
				# velocity consistent.
				remainder = collision.get_remainder()
				player.position += remainder
				pusher.position += remainder

		# If the player has been pushed off of the screen, lose the minigame.
		if player.position.x < -32.0:
			stop()
			emit_signal("lost")

	# Move the player.
	velocity = player.move_and_slide(velocity, Vector2.UP)
	# Detect if the player is grounded.
	grounded = player.is_on_floor()
