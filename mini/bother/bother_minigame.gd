extends Minigame
# A script for the "Bother the Cat!" minigame.


const POKES_TO_WIN: int = 16


# The number of times the cat has been poked.
var pokes: int = 0


# A progress bar showing how many pokes have happened
onready var progress_bar = $ProgressBar

# The perpetrator, I mean player
onready var hand: Sprite = $Hand
# The victim, I mean critter
onready var critter: Sprite = $Cat
# Where to put the hand during pats
onready var pat_point: Vector2 = $Cat/PatPoint.global_position


func _ready():
	progress_bar.set_max(POKES_TO_WIN)


func _input(event):
	if _unlock_controls:
		if event.is_action_pressed("action", false):
			pokes += 1
			progress_bar.set_value(pokes)
			hand.position = pat_point
			if pokes >= POKES_TO_WIN:
				emit_signal("won")
		elif event.is_action_released("action"):
			hand.position.y -= 100
			hand.position.x += 25
