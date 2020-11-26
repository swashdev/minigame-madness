extends Minigame
# A script for the shoot 'em up minigame


# The player's projectiles.
export (PackedScene) var bullet


# For testing.
func _ready():
	start()


# Unlock the player's controls on starting the minigame.
func start():
	_unlock_controls = true
	$Player.allow_movement = true


# The player has fired a projectile which must be spawned.
func _on_Player_shot():
	var shot = bullet.instance()
	add_child( shot )
	shot.position = $Player.position
	# Offset the shot so it lines up with the player's guns.
	shot.position.y -= 20
