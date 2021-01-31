extends "res://scenes/objects/Recognized.gd"


func triggered(result):
	if result=='arrow':
		$AnimatedSprite3D.play("mad")
