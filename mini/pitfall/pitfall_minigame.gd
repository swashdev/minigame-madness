extends Minigame
# A script for the "Get Across!" minigame.


# This enum represents the various hazards that may present themselves when
# the player starts the game.
enum Hazards { WATER, GATORS, PIT }

# Directions the vine might be swinging.
enum { LEFT, RIGHT }


# The maximum angle the vine can swing to.
const MAX_VINE_ANGLE: float = 25.0

# The speed at which the vine will swing.
const VINE_SWING_SPEED: float = 40.0


# The currently-selected hazard.
var _hazard: int

# The direction in which the vine is currently swinging.
var _direction = RIGHT

# Whether or not the player is currently swinging on the vine.
var _swinging: bool = false


# When the game is ready, choose a random hazard and do appropriate setup.
func _ready():
	_hazard = Hazards.values()[ randi() % Hazards.size() ]

	match _hazard:
		Hazards.WATER:
			# `WATER` is just the pond with the lily pads.  For that, we
			# dequeue the gators and the vine.  Nice and easy.
			$Gators.queue_free()
			$Vine.queue_free()

		Hazards.PIT:
			# `PIT` is the gaping hole over the pit.  Dequeue the lily pads
			# and the gators and reveal the pit.
			$LilyPads.queue_free()
			$Gators.queue_free()

			$Pit.show()

		Hazards.GATORS:
			# `GATORS` means we use the gators, so dequeue the lily pads and
			# the vine.
			$LilyPads.queue_free()
			$Vine.queue_free()

			# We need to connect the gators' "chomped" signals.
			var e1 = $Gators/Gator1.connect( "chomped", $IndianaJumpman, "die" )
			var e2 = $Gators/Gator2.connect( "chomped", $IndianaJumpman, "die" )

			if e1 != OK or e2 != OK:
				OS.alert( """Gators failed to connect their \"chomped\" signals!
e1: %d, e2: %d""" % [e1, e2], "Bad code detected!" )


# The minigame's main loop.  Pretty much just swings the vine.
func _process( delta ):
	if _hazard == Hazards.PIT:
		var rot = VINE_SWING_SPEED * delta

		if _direction == RIGHT:
			$Vine.rotation_degrees += rot
			if $Vine.rotation_degrees >= MAX_VINE_ANGLE:
				_direction = LEFT
		else:
			$Vine.rotation_degrees -= rot
			if $Vine.rotation_degrees <= -MAX_VINE_ANGLE:
				_direction = RIGHT

		# If the player is currently swinging on the vine, set their position to
		# roughly the tip of the vine.
		if _swinging:
			var new_pos = Vector2( 0, 22 ).rotated( $Vine.rotation )
			new_pos.x += $Vine.position.x - 4
			new_pos.y += $Vine.position.y + 2
			$IndianaJumpman.position = new_pos

			# If the player presses an input while swinging, cause them to hop off
			# the vine.
			if Input.is_action_just_pressed( "move_left" ) \
			or Input.is_action_just_pressed( "move_right" ) \
			or Input.is_action_just_pressed( "action" ):
				_swinging = false
				$IndianaJumpman.stop_swinging()


# Unlock the player's controls when the minigame starts.
func start():
	$IndianaJumpman.unlock()

	# If the gators are active, start their timers.
	if _hazard == Hazards.GATORS:
		$Gators/Gator1.start()
		$Gators/Gator2.start()


# Lock the player's controls when the minigame finishes.
func stop():
	$IndianaJumpman.lock()

	# If the gators are active, stop their timers.
	if _hazard == Hazards.GATORS:
		$Gators/Gator1.stop()
		$Gators/Gator2.stop()


# The player has died in some way, meaning they lose the minigame.
func _on_IndianaJumpman_died():
	stop()
	emit_signal( "lost" )


# The win zone has detected a body entering.  Since the player is the only
# body it scans for, this immediately triggers a victory.
func _on_WinZone_body_entered( _body ):
	stop()
	emit_signal( "won" )


# If the player touches the tip of the vine, he'll start swinging.
func _on_VineTip_body_entered( _body ):
	if $IndianaJumpman.get_state() != $IndianaJumpman.States.DEAD:
		_swinging = true
		$IndianaJumpman.start_swinging()
