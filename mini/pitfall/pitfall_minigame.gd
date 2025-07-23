extends Node2D
# A script for the "Get Across!" minigame.


# Mirroring the "won" and "lost" signals from the `Minigame` class.
signal won
signal lost


# This enum represents the various hazards that may present themselves when
# the player starts the game.
enum Hazards \
{
	WATER,
	PIT,
	DUCK_POND,
	GATORS,
}

# Directions the vine might be swinging.
enum { LEFT, RIGHT }


# The maximum angle the vine can swing to.
const MAX_VINE_ANGLE: float = 25.0

# The speed at which the vine will swing.
const VINE_SWING_SPEED: float = 80.0


# The currently-selected hazard.
var _hazard: int

# The direction in which the vine is currently swinging.
var _direction = RIGHT

# Whether or not the player is currently swinging on the vine.
var _swinging: bool = false


# The player character
onready var _player = $IndianaJumpman

# The lily pads used in the `WATER` hazard.
onready var _lily_pads = $LilyPads

# The vine and pit used in the `PIT` hazard.
onready var _vine = $Vine
onready var _vine_tip = $Vine/VineTip
onready var _pit = $Pit

# The gators used in the `GATORS` hazard.
onready var _gators = $Gators
onready var _gator_1 = $Gators/Gator1
onready var _gator_2 = $Gators/Gator2

# The duck
onready var _duck = $Duck


# When the game is ready, choose a random hazard and do appropriate setup.
func _ready():
	_hazard = randi() % 9
	match _hazard:
		0, 1, 2:
			_hazard = Hazards.WATER
		3, 4, 5:
			_hazard = Hazards.PIT
		6, 7:
			_hazard = Hazards.GATORS
		_:
			_hazard = Hazards.DUCK_POND

	match _hazard:
		Hazards.WATER:
			# `WATER` is just the pond with the lily pads.  For that, we
			# dequeue the gators and the vine.  Nice and easy.
			_gators.queue_free()
			_vine.queue_free()
			_duck.queue_free()

		Hazards.PIT:
			# `PIT` is the gaping hole over the pit.  Dequeue the lily pads
			# and the gators and reveal the pit.
			_lily_pads.queue_free()
			_gators.queue_free()
			_duck.queue_free()

			_pit.show()

		Hazards.DUCK_POND:
			# `DUCK_POND` means we use the duck, so dequeue everything else.
			_lily_pads.queue_free()
			_gators.queue_free()
			_vine.queue_free()

		Hazards.GATORS:
			# `GATORS` means we use the gators, so dequeue the lily pads and
			# the vine.
			_lily_pads.queue_free()
			_vine.queue_free()
			_duck.queue_free()

			# We need to connect the gators' "chomped" signals.
			var e1 = _gator_1.connect( "chomped", _player, "die" )
			var e2 = _gator_2.connect( "chomped", _player, "die" )

			if e1 != OK or e2 != OK:
				OS.alert( """Gators failed to connect their \"chomped\" signals!
e1: %d, e2: %d""" % [e1, e2], "Bad code detected!" )


# The minigame's main loop.  Pretty much just swings the vine.
func _process( delta ):
	if _hazard == Hazards.PIT:
		var rot = VINE_SWING_SPEED * delta

		if _direction == RIGHT:
			_vine.rotation_degrees += rot
			if _vine.rotation_degrees >= MAX_VINE_ANGLE:
				_direction = LEFT
		else:
			_vine.rotation_degrees -= rot
			if _vine.rotation_degrees <= -MAX_VINE_ANGLE:
				_direction = RIGHT

		# If the player is currently swinging on the vine, set their position to
		# roughly the tip of the vine.
		if _swinging:
			var new_pos = Vector2( 0, 22 ).rotated( _vine.rotation )
			new_pos.x += _vine.position.x - 4
			new_pos.y += _vine.position.y + 2
			_player.position = new_pos

			# If the player presses an input while swinging, cause them to hop off
			# the vine.
			if Input.is_action_just_pressed( "move_left" ) \
			or Input.is_action_just_pressed( "move_right" ) \
			or Input.is_action_just_pressed( "action" ):
				_swinging = false
				_player.stop_swinging()


# Unlock the player's controls when the minigame starts.
func start():
	_player.unlock()


# Lock the player's controls when the minigame finishes.
func stop():
	_player.lock()

	# If the gators are active, stop their timers.
	if _hazard == Hazards.GATORS:
		_gator_1.stop()
		_gator_2.stop()


# The player has died in some way, meaning they lose the minigame.
func _on_IndianaJumpman_died():
	stop()
	emit_signal( "lost" )


# The player character has reached the other side of the pond and signalled
# victory.
func _on_IndianaJumpman_won():
	stop()
	emit_signal( "won" )


# If the player touches the tip of the vine, he'll start swinging.
func _on_VineTip_body_entered( _body ):
	if _player.get_state() != _player.States.DEAD:
		_swinging = true
		_player.start_swinging()
	# Disconnect the signal so that the player can only grab the vine once.
	_vine_tip.disconnect("body_entered", self, "_on_VineTip_body_entered")
