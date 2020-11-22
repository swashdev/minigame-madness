extends Node2D
# A script for the za from the "Slice that 'Za!" minigame.


# A signal to inform the minigame that the 'za could not possibly be more
# sliced!
signal sliced

# A variable to keep track of the number of times the 'za has been sliced.
var _slices: int = 0


# Slices the 'za.
func slice():
	match _slices:
		0:
			$Half1.position.x -= 4
			$Half2.position.x += 4
		1:
			$Half1/Quadrant1.position.y -= 4
			$Half2/Quadrant1.position.y += 4
			$Half1/Quadrant2.position.y += 4
			$Half2/Quadrant2.position.y -= 4
		2:
			$Half1/Quadrant1/Slice1.position.y -= 2
			$Half1/Quadrant1/Slice1.position.x += 2
			$Half1/Quadrant1/Slice2.position.y += 2
			$Half2/Quadrant1/Slice1.position.y -= 2
			$Half2/Quadrant1/Slice2.position.y += 2
			$Half2/Quadrant1/Slice2.position.x -= 2
		3:
			$Half1/Quadrant2/Slice1.position.y -= 2
			$Half1/Quadrant2/Slice2.position.y += 2
			$Half1/Quadrant2/Slice2.position.x += 2
			$Half2/Quadrant2/Slice1.position.y += 2
			$Half2/Quadrant2/Slice2.position.y -= 2
			$Half2/Quadrant2/Slice2.position.x -= 2
			emit_signal( "sliced" )
			$NomTimer.start()
	if _slices < 3:
		_slices += 1


# Animate bites of 'za
func _on_NomTimer_timeout():
	var za_slices = [ \
		$Half1/Quadrant1/Slice1, $Half1/Quadrant1/Slice2,
		$Half1/Quadrant2/Slice1, $Half1/Quadrant2/Slice2,
		$Half2/Quadrant1/Slice1, $Half2/Quadrant1/Slice2,
		$Half2/Quadrant2/Slice1, $Half2/Quadrant2/Slice2,
		]
	# Hide one slice of 'za each time the timer goes off.
	for slice_of_za in za_slices:
		if slice_of_za.visible:
			slice_of_za.hide()
			break
	# Stop the timer if the last slice of 'za is gone.
	if not $Half2/Quadrant2/Slice2.visible:
		$NomTimer.stop()
