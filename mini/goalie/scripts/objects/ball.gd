extends KinematicBody2D
# A ball threatening the goalie's turf.


func _draw():
	draw_circle(Vector2.ZERO, 10.0, Color.white)
