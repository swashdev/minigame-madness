extends Minigame
# A script for the shoot 'em up minigame


# A signal to tell the `ShooterFrame` that the player's missile has been
# deployed.
signal missile_deployed

# The player's projectiles.
export (PackedScene) var bullet

# An explosion animation.
export (PackedScene) var explosion

# The target number of kills.
const KILLS_REQUIRED: int = 5

# An array of paths which can spawn enemies.
var _paths: Array
var _path_count: int

# The number of kills the player has.
var _kills: int = 0

# Whether or not the player has fired their missile.
var _fired_missile: bool = false

# Set to `true` if the player dies.  This will prevent the game from continuing
# to query the player in some circumstances.
var _player_died: bool = false

# A star node which can be instanced to create a starfield.
var _star = preload( "res://mini/shooter/scenes/effects/star/star.tscn" )


# Initialize the minigame by populating `paths` and setting `path_count`
func _ready():
	_paths = $Paths.get_children()
	_path_count = _paths.size()

	# Connect each path's "exploded" signal to the `_on_enemy_exploded`
	# function.
	for path in _paths:
		path.connect( "exploded", self, "_on_enemy_exploded" )


# The minigame's mainloop.  If the player has not fired their missile, have it
# follow the player.
func _process( _delta ):
	if not _fired_missile:
		$Missile.position.x = $Player.position.x


# Returns the number of kills the player has.  Used for the score counter.
func get_kills() -> int:
	return _kills


# Unlock the player's controls on starting the minigame.
func start():
	_unlock_controls = true
	$Player.allow_movement = true
	$EnemySpawnTimer.start()


# Stop player movement & enemy spawn timers.
func stop():
	_unlock_controls = false
	if not _player_died:
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


# An enemy has exploded and must be counted.
func _on_enemy_exploded( location ):
	# Add an explosion to the scene at the specified location.
	var boom = explosion.instance()
	boom.position = location
	# The position of the explosion has to be adjusted for the actual
	# minigame's on-screen position.
	boom.position.x -= position.x
	add_child( boom )
	boom.play()

	# Increment the player's kill counter and check for victory.
	_kills += 1
	if _kills >= KILLS_REQUIRED:
		stop()
		emit_signal( "won" )


# The player has died and must be deleted.  This function will cause a game
# over.
func _on_Player_died( location ):
	# The missile needs to be removed and disabled in order to avoid errors.
	if not _fired_missile:
		_fired_missile = true
		$Missile.queue_free()

	# Spawn an explosion much like in `_on_enemy_exploded()`
	var boom = explosion.instance()
	boom.position = location
	boom.position.x -= position.x
	add_child( boom )
	boom.play()

	# Delete the player character.
	$Player.queue_free()
	_player_died = true

	# End the game.  Note that the player may still win if they've killed enough
	# bad guys.
	decide()


func _on_StarSpawner_spawn_star( x_coordinate ):
	var star = _star.instance()
	star.rect_position = Vector2( x_coordinate, 0 )
	add_child( star )


# The player has fired their missile.  Shit's about to get real.
func _on_Player_fired_missile():
	if not _fired_missile:
		_fired_missile = true
		$Missile.fire()
		emit_signal( "missile_deployed" )
