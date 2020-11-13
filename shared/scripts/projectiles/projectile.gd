class_name Projectile2D
extends RigidBody2D
# A generic class for in-game projectiles of arbitrary speed, direction,
# shape, and size.


# The rate of spin for the projectile in degrees.
export (float) var spin_degrees = 0.0 setget set_spin, get_spin


func set_spin( new_spin: float ):
	spin_degrees = new_spin


func get_spin() -> float:
	return spin_degrees


# The default process will move the projectile in space and, if applicable,
# spin it.
func _process( delta ):
	if spin_degrees != 0.0:
		rotation_degrees += spin_degrees * delta


# Disappear when leaving the screen.
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
