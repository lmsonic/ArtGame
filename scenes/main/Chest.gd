extends "res://scenes/objects/Recognized.gd"


func triggered(result):
	if result=="key":
		$Spatial/Doll.show()
		
