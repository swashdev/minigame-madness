extends Path2D
# A scene for paths which spawn enemies in the shoot 'em up minigame.


# Which scene to use for the enemies spawned on the path.
export (PackedScene) var _enemy


# Spawns an enemy on the path.
func spawn_enemy():
	var enemy = _enemy.instance()
	add_child( enemy )
