class_name Projectile2D
extends RigidBody2D
# A generic class for in-game projectiles of arbitrary speed, direction,
# shape, and size.


# The rate of speed of the projectile, in pixels.
export (float) var _speed = 0.0 setget set_speed, get_speed

# The direction that the projectile faces, in degrees.
export (float) var _direction = 0.0 setget set_direction, get_direction

# The rate of spin for the projectile in degrees.
export (float) var spin_degrees = 0.0 setget set_spin, get_spin


# The default process will move the projectile in space and, if applicable,
# spin it.
func _process( delta ):
	if spin_degrees != 0.0:
		rotation_degrees += spin_degrees * delta


# Sets the projectile's speed and recalculates its linear velocity.
func set_speed( new_speed: float ):
	set_velocity( new_speed )


func get_speed() -> float:
	return _speed


# Sets the projectile's direction and recalculates its linear velocity.
func set_direction( new_direction: float ):
	set_velocity( _speed, new_direction )


func get_direction() -> float:
	return _direction


func set_spin( new_spin: float ):
	spin_degrees = new_spin


func get_spin() -> float:
	return spin_degrees


# Recalculates the projectile's linear velocity based on the `speed` &
# `direction`
func set_velocity( new_speed = _speed, new_direction = _direction ):
	_speed = new_speed
	_direction = new_direction
	linear_velocity = Vector2( _speed, 0 ).rotated( deg2rad( _direction ) )


# Disappear when leaving the screen.
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
