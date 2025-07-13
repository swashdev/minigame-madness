extends Minigame
# A script for the "Jump!" minigame.


# The speed of the player's vertical movement.
const GRAVITY: float = 2048.0
const JUMP_VELOCITY: float = 768.0

# The speed of the pushers.
const PUSHER_VELOCITY: Vector2 = Vector2(-660.0, 0.0)

# How quickly the background scrolls.
const BACKGROUND_SCROLL_SPEED: float = 110.0

# A little animation when the player jumps.
const ROTATION_SPEED: float = 360.0
const ROTATION_DEGREES: float = 90.0


# The player's current velocity.
var velocity: Vector2 = Vector2.ZERO

# Whether or not the player is currently on a floor.
var grounded: bool = false
# Keeps track of the player's rotation animation.
var jumped: bool = false
var rotation_animation: float = 0.0


# The player character.
onready var player: KinematicBody2D = $Player
onready var player_sprite: ColorRect = $Player/ColorRect

# The pushers (obstacles)
onready var pushers: Array = $Pushers.get_children()

# The scrolling starry background.
onready var background: Control = $Background


# The mainloop.
func _process(delta):
	var rotation_frame: float
	if _unlock_controls and jumped:
		rotation_frame = ROTATION_SPEED * delta
		rotation_animation += rotation_frame
		player_sprite.rect_rotation += rotation_frame
		if rotation_animation > ROTATION_DEGREES:
			player_sprite.rect_rotation = 0.0
			rotation_animation = 0.0
			jumped = false

	background.rect_position.x -= BACKGROUND_SCROLL_SPEED * delta


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
			jumped = false
			if Input.is_action_just_pressed("action") \
			or Input.is_action_just_pressed("move_up"):
				velocity.y -= JUMP_VELOCITY
				jumped = true

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


func stop():
	.stop()
	player_sprite.rect_rotation = 0.0
