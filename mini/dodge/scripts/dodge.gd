extends Minigame
# A script for the "Dodge!" minigame.


# When the minigame is ready, assign random positions to each of the three
# evil trains.
func _ready():
	var trains = [$EvilTrain1, $EvilTrain2, $EvilTrain3]
	var distance: float = 400.0
	var modifier: int = 1

	while modifier < 3:
		# Pick a random train and move it down the track.
		var index = randi() % trains.size()
		var train = trains[index]

		train.position.x += distance * modifier

		trains.remove( index )
		modifier += 1


# When the time has come to start the minigame, unlock the player's controls
# and release the evil trains.
func start():
	$Train.unlock()
	$EvilTrain1.unlock()
	$EvilTrain2.unlock()
	$EvilTrain3.unlock()


# When the minigame finishes, lock the player's controls and remove the evil
# trains.
func stop():
	$Train.unlock( false )
	$EvilTrain1.queue_free()
	$EvilTrain2.queue_free()
	$EvilTrain3.queue_free()
