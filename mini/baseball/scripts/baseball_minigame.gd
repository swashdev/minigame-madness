extends Minigame
# The "Hit a Home Run!" minigame.


# Used to determine if the player has swung
var _swung: bool = false


func _process( _delta ):
	if _unlock_controls:
		if !_swung:
			if Input.is_action_pressed( "ui_select" ):
				_swung = true
				$Batter.animation = "swing"
				$Batter.play()
