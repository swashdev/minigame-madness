extends Minigame
# A script for the "Bother the Cat!" minigame.


const POKES_TO_WIN: int = 16
const POKES_TO_ANGER: int = 12
const SQUISH_SCALE: Vector2 = Vector2(1.1, 0.9)
const NORMAL_SCALE: Vector2 = Vector2(1, 1)


# The number of times the cat has been poked.
var pokes: int = 0

# Textures to be used for the critter's face.
var face_awake: Texture = \
		preload("res://mini/bother/images/faces/awake.png")
var face_angry: Texture = \
		preload("res://mini/bother/images/faces/angry.png")


# A progress bar showing how many pokes have happened
onready var progress_bar = $ProgressBar

# The perpetrator, I mean player
onready var hand: Sprite = $Hand
# The victim, I mean critter
onready var critter: Sprite = $Cat
# The critter's face
onready var face: Sprite = $Cat/Face
# Where to put the hand during pats
onready var pat_point: Vector2 = $Cat/PatPoint.global_position


func _ready():
	progress_bar.set_max(POKES_TO_WIN)


func _input(event):
	if _unlock_controls:
		if event.is_action_pressed("action", false):
			pokes += 1
			progress_bar.set_value(pokes)
			critter.scale = SQUISH_SCALE
			hand.position = pat_point
			if pokes == 1:
				face.set_texture(face_awake)
			elif pokes == POKES_TO_ANGER:
				face.set_texture(face_angry)
			elif pokes >= POKES_TO_WIN:
				emit_signal("won")
		elif event.is_action_released("action"):
			hand.position.y -= 100
			hand.position.x += 25
			critter.scale = NORMAL_SCALE
