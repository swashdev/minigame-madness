extends StaticBody2D
# A script for the gator from the "Get Across!" minigame.


# Signals the game that the gator has chomped the player.
signal chomped


# The possible states of the gator, representing whether their mouth is
# `OPEN` or `CLOSED`.
enum State { CLOSED, OPEN, BLOCKED }


# Sprites associated with either `State`.
var Sprites = {
	State.CLOSED: preload( "res://mini/pitfall/images/obstacles/gator/closed.png" ),
	State.OPEN: preload( "res://mini/pitfall/images/obstacles/gator/open.png" ),
}


# The gator's current `State`.
var _state: int = State.CLOSED

# Informs the gator of whether or not the player is in their jaws.
var _player_here: bool = false


onready var _sprite = $Sprite
onready var _timer = $Timer


# Starts the gator's cycle.
func start():
	_timer.start()


# Closes the gator's mouth and stops their cycle.
func stop():
	_timer.stop()
	if _state == State.OPEN:
		_chomp()


# Changes the gator's state.
func set_state( state ):
	_state = state
	_sprite.texture = Sprites[_state]


# Tells the gator to chomp down on the player.
func _chomp():
	# Set the gator's state to `CLOSED`
	set_state( State.CLOSED )
	
	# See if the player is currently in the jaws.
	if _player_here:
		# If he is, signal chomped.
		emit_signal( "chomped" )


# Any time the timer times out, try to change the gator's state.
func _on_Timer_timeout():
	# If the gator's mouth is open, chomp down.
	if _state == State.OPEN:
		_chomp()

	# If the gator's state is `BLOCKED`, that means a previous attempt to open
	# the mouth has been blocked.  On this frame, the gator's state will be
	# set to `CLOSED` proper.
	elif _state == State.BLOCKED:
		_state = State.CLOSED
	# Otherwise, the gator's mouth is closed.  Check if the player is here.
	else:
		# If the player is here, the gator's mouth is blocked.
		if _player_here:
			_state = State.BLOCKED
		# Otherwise, open the gator's jaws.
		else:
			set_state( State.OPEN )


# If the head has detected a body has entered, that means the player is
# standing on the gator's head.  We need to flag this so the gator will know
# the player is here.
func _on_Head_body_entered( _body ):
	_player_here = true;


# If the head has detected a body has exited, that means the player has left
# the gator's head and the gator is now free to move.
func _on_Head_body_exited( _body ):
	_player_here = false;
