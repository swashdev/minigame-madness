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

# Set this to `true` when we're ready for the victory animation!
var won: bool = false
var animation_frames: int = 0
var animation_alpha: float = 0.0

# The perpetrator, I mean player
onready var hand: Sprite = $Hand
# The victim, I mean critter
onready var critter: Sprite = $Cat
# The critter's face
onready var face: Sprite = $Cat/Face
# Where to put the hand during pats
onready var pat_point: Vector2 = $Cat/PatPoint.global_position

# The end screen
onready var end_screen: ColorRect = $EndScreen
onready var end_title: Label = $EndScreen/Label


func _ready():
	progress_bar.set_max(POKES_TO_WIN)


func _input(event):
	if _unlock_controls:
		# The player can only pat the cat during the minigame.
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
				won = true
				_unlock_controls = false
	if not won:
		# The player is able to release their hand even after the minigame has
		# finished, as long as they haven't won the minigame.
		if event.is_action_released("action"):
			hand.position.y -= 100
			hand.position.x += 25
			critter.scale = NORMAL_SCALE


func _process(delta):
	if won:
		if animation_frames < 2:
			critter.position = hand.position
			hand.hide()
		elif animation_frames == 3:
			end_screen.show()
		else:
			if animation_alpha < 1:
				animation_alpha += delta
				end_title.modulate.a = animation_alpha
			else:
				emit_signal("won")
				won = false
		animation_frames += 1


func decide():
	_unlock_controls = false
	if won:
		emit_signal("won")
	else:
		emit_signal("lost")
