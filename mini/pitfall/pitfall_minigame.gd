extends Minigame
# A script for the "Get Across!" minigame.


# This enum represents the various hazards that may present themselves when
# the player starts the game.
enum Hazards { WATER, GATORS }


var _hazard: int


# When the game is ready, choose a random hazard and do appropriate setup.
func _ready():
	_hazard = Hazards.values()[ randi() % Hazards.size() ]

	match _hazard:
		Hazards.WATER:
			# `WATER` is just the pond with the lily pads.  For that, we
			# dequeue the gators.  Nice and easy.
			$Gators.queue_free()
		Hazards.GATORS:
			# `GATORS` means we use the gators, so dequeue the lily pads.
			$LilyPads.queue_free()

			# We need to connect the gators' "chomped" signals.
			var e1 = $Gators/Gator1.connect( "chomped", $IndianaJumpman, "die" )
			var e2 = $Gators/Gator2.connect( "chomped", $IndianaJumpman, "die" )

			if e1 != OK or e2 != OK:
				OS.alert( """Gators failed to connect their \"chomped\" signals!
e1: %d, e2: %d""" % [e1, e2], "Bad code detected!" )


# Unlock the player's controls when the minigame starts.
func start():
	$IndianaJumpman.unlock()

	# If the gators are active, start their timers.
	if _hazard == Hazards.GATORS:
		$Gators/Gator1.start()
		$Gators/Gator2.start()


# Lock the player's controls when the minigame finishes.
func stop():
	$IndianaJumpman.lock()

	# If the gators are active, stop their timers.
	if _hazard == Hazards.GATORS:
		$Gators/Gator1.stop()
		$Gators/Gator2.stop()


# The player has died in some way, meaning they lose the minigame.
func _on_IndianaJumpman_died():
	stop()
	emit_signal( "lost" )


# The win zone has detected a body entering.  Since the player is the only
# body it scans for, this immediately triggers a victory.
func _on_WinZone_body_entered( _body ):
	stop()
	emit_signal( "won" )
