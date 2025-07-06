extends Minigame
# A Dance Dance Revolution clone.


# Possible scores gotten from triggering an arrow.  MISS is 0.
enum { MISS, OK, GOOD, GREAT, PERFECT }


# Directions which arrows might be pointing when they spawn in.
enum { UP, DOWN, LEFT, RIGHT }


# x coordinate values for each of the various "lanes" the arrows will fall down.
# Note that these values correlate with the target sprites in the `Targets`
# node.
const LANES: Dictionary = \
{
	LEFT: 200.0,
	DOWN: 280.0,
	UP: 360.0,
	RIGHT: 440.0,
}


# The maximum number of arrows to spawn.
const MAX_ARROWS: int = 8
const SCORE_TO_WIN: int = OK * MAX_ARROWS


# A template for arrows to spawn.
onready var arrow_t = preload( "res://mini/dance/scenes/ui/dance_arrow.tscn" )

# A hint for spawning positions.
onready var spawn_y: float = $SpawnPosition.position.y

# The score indicator that shows the player how close they were.
onready var announcer = $Label


# A counter for spawned arrows.
var spawned_arrows: int = 0

# The player's score.
var player_score: int = 0

# The progress bars are split into three sections.
onready var progress_bar_1: ProgressBar = $ProgressBar1_1
onready var progress_bar_2: ProgressBar = $ProgressBar2_1
onready var progress_bar_3: ProgressBar = $ProgressBar3_1


func _ready():
	progress_bar_1.share( $ProgressBar1_2 )
	progress_bar_2.share( $ProgressBar2_2 )
	progress_bar_3.share( $ProgressBar3_2 )


# Override `start` and `stop` to start the arrow timer.  `start` will also spawn
# the first arrow.
func start():
	_spawn_arrow()
	$ArrowTimer.start()

func stop():
	$ArrowTimer.stop()


# In order to `decide` whether the player won or not, the minigame will check
# if the player has scored the equivalent of a "good" for every arrow.
func decide():
	stop()
	if player_score >= SCORE_TO_WIN:
		emit_signal( "won" )
		if player_score >= PERFECT * MAX_ARROWS:
			announcer.set_text( "GODLIKE!!!!!" )
		else:
			announcer.set_text( "YOU ROCK!!!" )
		announcer.add_color_override( "font_color", Color.red )
	else:
		emit_signal( "lost" )
		announcer.set_text( "Too Bad!" )
		announcer.add_color_override( "font_color", Color.whitesmoke )


# Spawns an arrow.
func _spawn_arrow():
	var arrow = arrow_t.instance()
	# Spawn the arrow.
	add_child( arrow )

	# Select a random direction and set the arrow to that direction.
	var direction: int = randi() % 4
	arrow.set_direction( direction )

	# Position the arrow in the appropriate lane for its direction.
	arrow.position = Vector2( LANES[direction], spawn_y )

	# Connect the arrow to the player's score.
	arrow.connect( "despawned", self, "_add_score" )

	# Increment the arrow counter.  If it reaches the max, stop spawning.
	spawned_arrows += 1
	if spawned_arrows >= MAX_ARROWS:
		$ArrowTimer.stop()


# An arrow has despawned, causing the minigame to increment the player's score.
func _add_score( score: int ):
	player_score += score
	progress_bar_1.set_value( player_score )
	progress_bar_2.set_value( player_score )
	progress_bar_3.set_value( player_score )

	if score <= MISS:
		announcer.set_text( "MISS" )
		announcer.add_color_override( "font_color", Color.gray )
	elif score == OK:
		announcer.set_text( "OK" )
		announcer.add_color_override( "font_color", Color.blue )
	elif score == GOOD:
		announcer.set_text( "GOOD!" )
		announcer.add_color_override( "font_color", Color.orange )
	elif score == GREAT:
		announcer.set_text( "GREAT!!" )
		announcer.add_color_override( "font_color", Color.green )
	elif score == PERFECT:
		announcer.set_text( "PERFECT!!!" )
		announcer.add_color_override( "font_color", Color.red )
	else:
		announcer.set_text( "ORGASMIC!!!" )
		announcer.add_color_override( "font_color", Color.white )
