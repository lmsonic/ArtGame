extends "res://scenes/objects/Recognized.gd"

func triggered(result):
	if result=="hand":
		$Doll.play("red")
