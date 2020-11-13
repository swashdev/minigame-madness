class_name Projectile2D
extends RigidBody2D
# A generic class for in-game projectiles of arbitrary speed, direction,
# shape, and size.


# Disappear when leaving the screen.
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
