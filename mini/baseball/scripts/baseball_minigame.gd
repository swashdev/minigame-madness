extends Minigame
# The "Hit a Home Run!" minigame.


# Used to determine if the player has swung
var _swung: bool = false


func _process( _delta ):
	if _unlock_controls:
		# If the baseball exits stage left, signal loss and end the game.
		if $Baseball.position.x < $SwingMax.position.x:
			_unlock_controls = false
			emit_signal( "lost" )
		elif !_swung:
			if Input.is_action_pressed( "action" ):
				_swung = true
				_unlock_controls = false
				$Spacebar.dim()
				$Batter.animation = "swing"
				$Batter.play()
				# The animation is so fast that I'm not even going to wait
				# for it to finish; we'll assume win state relies on player's
				# reflexes, not the animation speed.
				# Check what collision detection bodies the ball is hitting
				# right now.
				var ball_x = $Baseball.position.x
				if ball_x > $SwingMax.position.x \
				and ball_x < $SwingMin.position.x:
					emit_signal( "won" )
					$Baseball.set_direction( -45.0 )
				else:
					$Pitcher/Timer.stop()
					emit_signal( "lost" )


# Unlock the controls & start the pitcher's timer.
func start():
	.start()
	$Pitcher/Timer.start()
	$Spacebar.light()


# The pitcher has thrown the ball, so make the ball visible & start it on its
# way.
func _on_Pitcher_threw_ball():
	$Baseball.set_visible( true )
	$Baseball.set_speed( 640.0 )
	$Spacebar.blink_rapidly()
