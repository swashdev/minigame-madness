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


# A template for arrows to spawn.
onready var arrow_t = preload( "res://mini/dance/scenes/ui/dance_arrow.tscn" )

# A hint for spawning positions.
onready var spawn_y: float = $SpawnPosition.position.y


# A counter for spawned arrows.
var spawned_arrows: int = 0

# The player's score.
var player_score: int = 0


# Override `start` and `stop` to start the arrow timer.  `start` will also spawn
# the first arrow.
func start():
	_spawn_arrow()
	$ArrowTimer.start()

func stop():
	$ArrowTimer.stop()


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
	$Label.text = "%d / %d" % [player_score, 2 * MAX_ARROWS]
