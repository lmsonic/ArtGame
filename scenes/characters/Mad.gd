extends Spatial

func _on_StaticBody_body_entered(body):
	if body is Player and Globals.has_key:
		$AnimatedSprite3D.play("mad")
