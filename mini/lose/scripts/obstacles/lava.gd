extends Area2D
# A script for the lava from the "Lose" minigame.


# The lava touches Fluffy, causing him to die.
func _on_Lava_body_entered( body ):
	body.die()
	queue_free()
