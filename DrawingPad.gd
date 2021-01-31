extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var extracted:=false

# Called when the node enters the scene tree for the first time.
func _input(event):
	if event.is_action_pressed("ui_select"):
		if not extracted:
			$AnimationPlayer.play("extract")
			extracted=!extracted
		else:
			$AnimationPlayer.play("zip")
			extracted=!extracted
