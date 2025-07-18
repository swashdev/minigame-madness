extends Minigame
# A script for the "Dodge!" minigame.


onready var _player = $Train


# When the minigame is ready, assign random positions to each of the three
# evil trains.
func _ready():
	var trains = [$EvilTrain1, $EvilTrain2, $EvilTrain3]
	var index: int = 0
	var train: Node
	var distance: float = 400.0

	trains.shuffle()
	while index < 3:
		# Pick a random train and move it down the track.
		train = trains[index]
		train.position.x += distance * index
		index += 1

	index = 0
	trains.shuffle()
	while index < 3:
		# Randomize the order of the trains.
		train = trains[index]
		train.position.y = 130 + (112 * index)
		index += 1


# If the game ends due to timeout rather than player loss, rotate the player
# so that they are driving forward.
func decide():
	emit_signal( "won" )
	_player.unlock( false )
	_player.rotation_degrees = 0.0


# When the time has come to start the minigame, unlock the player's controls
# and release the evil trains.
func start():
	_player.unlock()
	$EvilTrain1.unlock()
	$EvilTrain2.unlock()
	$EvilTrain3.unlock()


# When the minigame finishes, lock the player's controls and remove the evil
# trains.
func stop():
	_player.unlock( false )


# The train has detected a collision with an evil train.
func _on_player_crashed():
	# Stop the evil train.
	#body.unlock( false )
	# Stop scrolling the background.
	$ParallaxBackground.stop_scrolling()

	# Signal loss and stop the minigame.
	stop()
	emit_signal( "lost" )
