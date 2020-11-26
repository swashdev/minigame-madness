extends Area2D
# A script for the player character from the shoot 'em up minigame.


# Signals the gameloop that the player is firing a shot.
signal shot

# The player's speed.
const SPEED: float = 400.0

# Whether or not to unlock movement.
var allow_movement: bool = false

# Whether or not the player's shot has cooled down.
var _cooldown: bool = true


# The player's mainloop, pretty much standard movement stuff.
func _process( delta ):
	if allow_movement:
		var speed = SPEED * delta
		if Input.is_action_pressed( "move_right" ):
			position.x += speed
		if Input.is_action_pressed( "move_left" ):
			position.x -= speed
		position.x = clamp( position.x, 20, 220 )
		# The player fires a standard bullet with the spacebar.
		if Input.is_action_pressed( "action" ):
			# Only fire the shot if the player's cooldown timer has expired.
			if _cooldown:
				# Restart the cooldown timer.
				_cooldown = false
				$ShotCooldown.start()
				# Signal that the player has fired.
				emit_signal( "shot" )
				# Play the exhaust animation.
				$Sprite/GunExhaust.frame = 0


# The player's cooldown timer has expired, allowing them to fire another shot.
func _on_ShotCooldown_timeout():
	_cooldown = true
