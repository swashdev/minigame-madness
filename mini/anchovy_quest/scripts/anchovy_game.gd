extends Minigame
# The class for the anchovy minigame.


# The max & minimum speed of the in-game pizzas.
const MAX_PIZZA: float = 200.0
const MIN_PIZZA: float = 100.0

# The max & minimum distance from the player that pizzas will spawn.
const MIN_DISTANCE: float = 200.0
const MAX_DISTANCE: float = 300.0

# The scene to be used for the initial pizza instances.
export (PackedScene) var _pizza
# The scene to be used for explosion animations.
export (PackedScene) var _explosion
# The scene to be used for the player's bullets.
export (PackedScene) var _bullet

# An array storing the initial pizzas.  Initialized in `_init`
var pizzas


# When the game is initialized, generate three pizzas at random locations.
func _ready():
	pizzas = [ _pizza.instance(), _pizza.instance(), _pizza.instance() ]

	for pizza in pizzas:
		# Spawn the pizza a random distance away from the player.
		var pizza_position: Vector2 = $Player.position
		pizza_position.x += rand_range( MIN_DISTANCE, MAX_DISTANCE )
		pizza_position = pizza_position.rotated( deg2rad( randi() % 360 ) )
		pizza_position.x = wrapf( pizza_position.x, pizza.MIN_X, pizza.MAX_X )
		pizza_position.y = wrapf( pizza_position.y, pizza.MIN_Y, pizza.MAX_Y )
		pizza.position = pizza_position
		add_child( pizza )


# Start the game by unlocking the controls and setting the pizzas in motion.
func start():
	_unlock_controls = true
	$Player.allow_movement = true

	# Assign a linear velocity and spin to each of the pizzas.
	for pizza in pizzas:
		var velocity = Vector2( rand_range( MIN_PIZZA, MAX_PIZZA ), 0 )
		velocity = velocity.rotated( deg2rad( randi() % 360 ) )
		pizza.set_velocity( velocity )


# If the player makes it to the end of the timer without dying, they win.
func decide():
	emit_signal( "won" )


# If the player has been hit, replace them with an explosion, remove them
# from the game, and signal loss.
func _on_Player_hit():
	var explosion = _explosion.instance()
	explosion.position = $Player.position
	add_child( explosion )
	explosion.play()
	$Player.queue_free()
	emit_signal( "lost" )


# The player has asked us to fire a projectile.
func _on_Player_shoot( location, direction ):
	var bullet = _bullet.instance()
	add_child( bullet )
	# Place the bullet on the player's designated projectile spawn point.
	bullet.position = location
	# Set the bullet's direction appropriately.
	bullet.set_direction( direction )
	# Connect the bullet's collision detection.
	bullet.connect( "collided", self, "_on_bullet_collided" )


# A pepperoni has reported a collision.
func _on_bullet_collided( data: KinematicCollision2D ):
	var body = data.get_collider()
	body.explode()
