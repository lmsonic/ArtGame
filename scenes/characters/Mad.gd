extends Spatial

func _on_StaticBody_body_entered(body):
	if body is Player and Globals.has_doll:
		$AnimatedSprite3D.play("mad")
		get_tree().call_group("door","animate","2")
