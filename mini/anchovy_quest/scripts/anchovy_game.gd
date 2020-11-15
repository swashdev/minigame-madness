extends Minigame
# The class for the anchovy minigame.


# The max & minimum speed of the in-game pizzas.
const MAX_PIZZA: float = 200.0
const MIN_PIZZA: float = 100.0

# The scene to be used for the initial pizza instances.
export (PackedScene) var _pizza

# An array storing the initial pizzas.  Initialized in `_init`
var pizzas


# When the game is initialized, generate three pizzas at random locations.
func _ready():
	pizzas = [ _pizza.instance(), _pizza.instance(), _pizza.instance() ]

	for pizza in pizzas:
		# Spawn the pizza a random distance away from the player.
		var pizza_position: Vector2 = $Player.position
		pizza_position.x += rand_range( 100.0, 200.0 )
		pizza_position = pizza_position.rotated( deg2rad( randi() % 360 ) )
		pizza.position = pizza_position
		add_child( pizza )


func start():
	_unlock_controls = true
	$Player.allow_movement = true

	# Assign a linear velocity and spin to each of the pizzas.
	for pizza in pizzas:
		var velocity = Vector2( rand_range( MIN_PIZZA, MAX_PIZZA ), 0 )
		velocity = velocity.rotated( deg2rad( randi() % 360 ) )
		pizza.linear_velocity = velocity
