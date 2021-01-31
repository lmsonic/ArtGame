extends "res://scenes/objects/Recognized.gd"

var opened:=false

func triggered(result):
	if (self.global_position-player.global_position).length<distanceToTrigger:
		if result=="hand" and opened:
			$Doll.play("red")
		elif result=="key":
			Globals.has_key=true
			$Doll.show()
			$AnimationPlayer.play("open")
			get_parent().play("open")
			opened=true
