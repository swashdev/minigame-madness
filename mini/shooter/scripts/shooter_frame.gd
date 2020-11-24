extends Minigame
# A script for the frame around the shooter minigame.


# Since the ShooterFrame functions as a frame around the actual minigame, this
# script pretty much defers everything to the ShooterMinigame.


func decide():
	$Minigame.decide()


func start():
	$Minigame.start()


func stop():
	$Minigame.stop()
