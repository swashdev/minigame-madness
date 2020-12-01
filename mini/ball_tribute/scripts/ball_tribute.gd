extends Minigame
# A script for the Ball tribute.


# Initialize the player in the correct position.
func _ready():
	$Ball.position = $PlayerStart.position
