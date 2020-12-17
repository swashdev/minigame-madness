class_name Explosion
extends AnimatedSprite
# An explosion which animates once and then disappears.


# Remove the explosion as soon as it is done animating.
func _on_Explosion_animation_finished():
	queue_free()
