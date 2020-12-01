extends Minigame
# A script for the Ball tribute.


# Move the player back to the spawn point.
func respawn():
	$Ball.respawn( $PlayerStart.position )
