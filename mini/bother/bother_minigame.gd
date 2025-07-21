extends Minigame
# A script for the "Bother the Cat!" minigame.


const POKES_TO_WIN: int = 16


# The number of times the cat has been poked.
var pokes: int = 0


func _input(event):
	if _unlock_controls:
		if event.is_action_pressed("action", false):
			pokes += 1
			if pokes >= POKES_TO_WIN:
				emit_signal("won")
