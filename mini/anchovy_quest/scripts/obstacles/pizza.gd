extends "res://mini/anchovy_quest/scripts/obstacles/pizza_slice.gd"
# A pizza combining two pizza slices.


# This scene acts as a template for the pizzas that come out of the HalfPizza
# when it explodes.
export (PackedScene) var _slice


# This `explode` function expands on the explosion from `PizzaSlice` by
# creating two `PizzaSlice`s which emerge from the exploding `Pizza`
func explode():
	var slice1 = _slice.instance()
	var slice2 = _slice.instance()
	get_parent().add_child( slice1 )
	get_parent().add_child( slice2 )

	slice1.position = position
	slice2.position = position

	# Adjust the velocities of the two slices by rotating each of them.
	slice1.set_velocity( get_velocity().rotated( deg2rad( 45.0 ) ) )
	slice1.set_spin( get_spin() )
	slice2.set_velocity( get_velocity().rotated( deg2rad( -45.0 ) ) )
	slice2.set_spin( get_spin() * -1.0 )

	.explode()
