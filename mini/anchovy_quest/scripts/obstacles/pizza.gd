class_name Pizza
extends RigidBody2D
# A colliding pizza that flies through space trying to smoosh anchovies.


# Determines how quickly the pizza's sprite and collision polygon will spin.
var spin_degrees: float = 0.0 setget set_spin, get_spin


# The pizza slice has a very simple life; this process does nothing but spin
# the slice independent of its movement vectors.
func _process( delta ):
	if spin_degrees != 0.0:
		$Sprite.rotation_degrees += spin_degrees * delta
		$CollisionPolygon2D.rotation_degrees += spin_degrees * delta
	._process( delta )


func set_spin( new_spin: float ):
	spin_degrees = new_spin


func get_spin() -> float:
	return spin_degrees
