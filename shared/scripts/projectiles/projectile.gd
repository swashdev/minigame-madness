class_name Projectile2D
extends RigidBody2D
# A generic class for in-game projectiles of arbitrary speed, direction,
# shape, and size.


# Connect signals from children to relevant functions.
func _ready():
	$VisibilityNotifier2D.connect( "screen_exited", self, \
			"_on_VisibilityNotifier2D_screen_exited" )


# Disappear when leaving the screen.
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()