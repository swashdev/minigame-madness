extends Node2D
# An explosion effect set off by the Dragon Missile from the "Shoot Five!"
# minigame.


# Yes, this whole script exists literally just to draw a circle.  What of it?
func _draw():
	draw_circle(position, 120.0, Color.white)
