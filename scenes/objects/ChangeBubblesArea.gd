extends Area


func _on_Area2_body_entered(body):
	if body is Player:
		get_tree().call_group("bubbleTextures","update_textures",["question"])


func _on_Area2_body_exited(body):
	if body is Player:
		get_tree().call_group("bubbleTextures","update_textures",["question","eye","whatsmissing"])
