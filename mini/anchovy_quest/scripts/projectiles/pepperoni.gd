class_name Pepperoni
extends Projectile2D
# A projectile for the player to fire which destroys pizzas.


# If the pepperoni enters a pizza, instruct the pizza to explode and then
# self-destruct.
func _on_Pepperoni_body_entered( body ):
	body.explode()
	queue_free()
