extends "res://scenes/objects/Recognized.gd"

var opened:=false
var red:=false
func triggered(result):
	if (self.transform.origin-player.transform.origin).length()<distanceToTrigger:
		if result=="hand" and opened:
			$Doll.play("red")
			red=true
		if result=="key":
			$Doll.show()
			$AnimationPlayer.play("open")
			get_parent().play("open")
			opened=true

func _on_Area_body_entered(body):
	if body is Player and red:
		Globals.has_doll=true
		queue_free()
