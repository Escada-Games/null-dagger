extends Area2D
func _ready():
	$collisionShape2D.shape.extents=($sprite.texture.get_size()/Vector2($sprite.hframes,$sprite.vframes))*$sprite.scale/2
func _on_mirror_body_entered(body):
	if body.is_in_group("glitchDagger"):
		body.vectorVelocity.x*=-0.75
		body.vectorVelocity.y*=0.75