extends Minigame
# The "Lose!" minigame.


# Possible hazards
enum Hazards { NO_BRIDGE, SPIKE, ARCHER }

# What kind of hazard has been selected for this particular game.
var _hazard: int


# When ready, initialize the game by choosing a hazard and setting up
# appropriately.
func _ready():
	# For testing:
	randomize()
	_hazard = Hazards.values()[ randi() % Hazards.size() ]
	match _hazard:
		Hazards.ARCHER:
			$Spike.queue_free()
# warning-ignore:return_value_discarded
			$Archer.connect( "shot", self, "_on_Archer_shot" )
		Hazards.NO_BRIDGE:
			$Spike.queue_free()
			$Bridge.queue_free()
			# Fall through to next case
			continue
		Hazards.NO_BRIDGE, Hazards.SPIKE:
			$Archer.queue_free()
	# For testing:
	start()


# Starting the "Lose!" minigame requires that we activate certain traps based
# on what the selected hazard was at initialization.
func start():
	match _hazard:
		Hazards.ARCHER:
			$Archer/Timer.start()
		Hazards.SPIKE:
			$Spike/Timer.start()


func _on_Archer_shot( arrow: PackedScene, position ):
	var bullet = arrow.instance()
	bullet.position = position
	add_child( bullet )
