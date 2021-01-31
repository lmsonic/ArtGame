extends Sprite3D



func _on_Area_body_entered(body):
	if body is Player:
		Globals.notebook_collected=true
		queue_free()
