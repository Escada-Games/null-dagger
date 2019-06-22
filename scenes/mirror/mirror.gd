extends Area2D
func _ready():
	$collisionShape2D.shape.extents=($sprite.texture.get_size()/Vector2($sprite.hframes,$sprite.vframes))*$sprite.scale/2
	$spriteGlow.scale=$sprite.scale
func _on_mirror_body_entered(body):
	if body.is_in_group("glitchDagger"):
		$sfx.pitch_scale=rand_range(0.9,1.1)
		$sfx.play()
		body.vectorVelocity.x*=-0.75
		body.vectorVelocity.y*=0.75
		$twnSpriteGlow.interpolate_property($spriteGlow,"modulate:a",1,0,0.5,Tween.TRANS_EXPO,Tween.EASE_IN)
		$twnSpriteGlow.start()