extends Area2D
# A script for the evil exit sign from the "Lose" minigame.


# Fluffy has touched the evil exit sign and falls over.
func _on_EvilExitSign_body_entered( body ):
	body.fall_over()
	queue_free()
