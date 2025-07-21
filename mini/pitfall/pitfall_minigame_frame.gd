extends Minigame
# A script for the frame around the "Get Across!" minigame.


# Most of the logic of this minigame is handled by the `PitfallMinigame` node,
# which is actually the original minigame node converted into a Node2D.
onready var minigame = $ViewportContainer/Viewport/PitfallMinigame


func start():
	minigame.start()


func stop():
	minigame.stop()
