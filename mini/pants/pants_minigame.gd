extends Minigame
# The main script for the "Put on Pants!" minigame.


# A list of available sprites for the pants.
var _pants_sprites = [
	preload( "res://mini/pants/images/pants/jeans.png" ),
	preload( "res://mini/pants/images/pants/jeans_shorts.png" ),
	preload( "res://mini/pants/images/pants/cargo_pants.png" ),
	preload( "res://mini/pants/images/pants/cargo_shorts.png" ),
	preload( "res://mini/pants/images/pants/dress_pants.png" ),
	preload( "res://mini/pants/images/pants/camo_pants.png" ),
	preload( "res://mini/pants/images/pants/clown_pants.png" ),
	preload( "res://mini/pants/images/pants/kilt.png" ),
	# Comma on last line intentional for efficient diff files.
]

# A template for random pants.
var pants_template = preload( "res://mini/pants/scenes/pants/pants.tscn" )


func start():
	_unlock_controls = true
	$PantsMan.allow_movement = true
	$PantsTimer.start()
	# Spawn a pair of pants immediately when the game starts.
	_spawn_pants()


func stop():
	_unlock_controls = false
	$PantsMan.allow_movement = false
	$PantsTimer.stop()
	# Disable collision on the player so that pants don't stack.
	$PantsMan/CollisionShape2D.disabled = true


# Spawn pants in a random position.
func _spawn_pants():
	var pants = pants_template.instance()

	# Get a random spawn position.
	$PantsPath/PantsSpawnPoint.unit_offset += randf()
	pants.position = $PantsPath/PantsSpawnPoint.global_position

	# Give the pants a random sprite.
	var sprite = randi() % _pants_sprites.size()
	pants.get_node( "Sprite" ).texture = _pants_sprites[ sprite ]

	# Connect the pants's "collided" signal.
	var error = pants.connect( "collided", self, "_on_pants_collide" )
	if error != OK:
		push_error( "Error code %d: Pants at index %d couldn\'t connect to the collision function." % [error, pants.get_index()] )

	# Add the pants to the scene.
	add_child( pants )


# When the pants timer goes off, spawn the pants.
func _on_PantsTimer_timeout():
	_spawn_pants()


# When the pants collide, put the pants on the player and end the game with a
# win.
func _on_pants_collide( idx ):
	stop()

	# Put the pants on the player.
	var pants = get_child( idx )
	pants.position = $PantsMan.position
	# Hide the player's fig leaf so it doesn't poke out of the pants.
	$PantsMan/FigLeaf.hide()

	emit_signal( "won" )
