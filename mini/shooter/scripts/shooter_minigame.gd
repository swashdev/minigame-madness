extends Minigame
# A script for the shoot 'em up minigame


# The player's projectiles.
export (PackedScene) var bullet

# An explosion animation.
export (PackedScene) var explosion

# An array of paths which can spawn enemies.
var _paths: Array
var _path_count: int


# Initialize the minigame by populating `paths` and setting `path_count`
func _ready():
	_paths = $Paths.get_children()
	_path_count = _paths.size()


# Unlock the player's controls on starting the minigame.
func start():
	_unlock_controls = true
	$Player.allow_movement = true
	$EnemySpawnTimer.start()


# Stop player movement & enemy spawn timers.
func stop():
	_unlock_controls = false
	$Player.allow_movement = false
	$EnemySpawnTimer.stop()


# The player has fired a projectile which must be spawned.
func _on_Player_shot():
	var shot = bullet.instance()
	add_child( shot )
	shot.position = $Player.position
	# Offset the shot so it lines up with the player's guns.
	shot.position.y -= 20


# The enemy spawn timer has expired, time to spawn a baddy.
func _on_EnemySpawnTimer_timeout():
	var path = _paths[ randi() % _path_count ]
	path.spawn_enemy()
