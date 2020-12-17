extends KinematicBody2D
# A colliding pizza that flies through space trying to smoosh anchovies.


# This variable contains the pizza's "Explosion" scene, which it spawns in as
# its explosion animation.
export (PackedScene) var _explosion

# Determines how quickly the pizza's sprite and collision polygon will spin.
var spin_degrees: float = 0.0 setget set_spin, get_spin

# Determines the pizza's velocity.
var _velocity: Vector2 setget set_velocity, get_velocity


# Choose a random spin at initialization.
func _init():
	spin_degrees = rand_range( 90.0, 180.0 )
	if randi() % 2 == 0:
		spin_degrees *= -1


# The pizza slice has a very simple life; this process does nothing but spin
# the slice independent of its movement vectors.
func _physics_process( delta ):
	if spin_degrees != 0.0:
		$Sprite.rotation_degrees += spin_degrees * delta
		$CollisionPolygon2D.rotation_degrees += spin_degrees * delta
	
	# Move & wrap around the edges of the screen.
# warning-ignore:return_value_discarded
	move_and_slide( _velocity )
	position.x = wrapf( position.x, 0, 640.0 )
	position.y = wrapf( position.y, 0, 480.0 )


func set_spin( new_spin: float ):
	spin_degrees = new_spin


func get_spin() -> float:
	return spin_degrees


# Sets the velocity of the pizza.
func set_velocity( vector: Vector2 ):
	_velocity = vector


# Returns the velocity of the pizza.
func get_velocity() -> Vector2:
	return _velocity


# Sets the speed of the pizza.
func set_speed( speed: float ):
	set_velocity( get_velocity().normalized() * speed )


# Returns the speed of the pizza.
func get_speed() -> float:
	return get_velocity().length()


# Sets the direction of travel.
func set_direction( degrees: float ):
	var vector: Vector2 = get_velocity()
	var new_vector = Vector2( vector.length(), 0 )
	set_velocity( new_vector.rotated( deg2rad( degrees ) ) )


# Returns the direction of travel in degrees.
func get_direction() -> float:
	return rad2deg( get_velocity().angle() )


# This function causes the pizza slice to explode by spawning an `Explosion`
# and then exiting the queue.
func explode():
	var explosion = _explosion.instance()
	# Add the explosion scene to the parent tree, so that it will persist
	# after this node has been freed from the queue.
	get_parent().add_child( explosion )

	# Set the explosion's coordinates to the coordinates for the current node.
	explosion.position = position
	# Play the explosion's animation, which will trigger the rest of its
	# script.
	explosion.play()

	# Exit stage none.
	queue_free()
