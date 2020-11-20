extends Area2D
# A scene for the Fluffy platformer character in the "Lose!" minigame.


# Horizontally flips Fluffy's sprite.
func flip( yn: bool ):
	# Fluffy's sprite is already flipped, so we do the opposite of what the
	# parameters say.
	$Sprite.flip_h = !yn
	# If the sprite is being flipped, we need to adjust the sprite offset to
	# recenter it.  We won't worry too much about animations here, since they
	# don't move the center of mass around too much.
	if yn:
		$Sprite.offset = Vector2( -5.5, -8 )
	else:
		$Sprite.offset = Vector2( -10.5, -8 )
