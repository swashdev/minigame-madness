extends Minigame
# A Dance Dance Revolution clone.


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


# A template for arrows to spawn.
onready var arrow_t = preload( "res://mini/dance/scenes/ui/dance_arrow.tscn" )

# A hint for spawning positions.
onready var spawn_y: float = $SpawnPosition.position.y


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
