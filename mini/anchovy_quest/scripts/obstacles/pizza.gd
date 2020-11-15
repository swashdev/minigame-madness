class_name Pizza
extends RigidBody2D
# A colliding pizza that flies through space trying to smoosh anchovies.


# This variable contains the pizza's "Explosion" scene, which it spawns in as
# its explosion animation.
export (PackedScene) var _explosion

# Determines how quickly the pizza's sprite and collision polygon will spin.
var spin_degrees: float = 0.0 setget set_spin, get_spin


# The pizza slice has a very simple life; this process does nothing but spin
# the slice independent of its movement vectors.
func _process( delta ):
	if spin_degrees != 0.0:
		$Sprite.rotation_degrees += spin_degrees * delta
		$CollisionPolygon2D.rotation_degrees += spin_degrees * delta

	# Wrap around the edges of the screen.
	position.x = wrapf( position.x, 0, 640.0 )
	position.y = wrapf( position.y, 0, 480.0 )


func set_spin( new_spin: float ):
	spin_degrees = new_spin


func get_spin() -> float:
	return spin_degrees


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
