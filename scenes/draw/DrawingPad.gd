extends Spatial
onready var player:= $"../.."

var extracted:=false setget set_extracted

onready var draw=$GUIPanel3D/Viewport/Draw

#when the drawing is extracted/zipped, the player stops, the drawing stops
func set_extracted(value:bool):
	if Globals.notebook_collected:
		extracted=value
		draw.extracted=value
		player.extracted=value
		player.get_node("AnimatedSprite3D").play("idle")
	#print(extracted)
	




#extacts/zips the drawing
func _input(event):
	if event.is_action_pressed("ui_select"):
		if Globals.notebook_collected:
			if not extracted:
				$AnimationPlayer.play("extract")
				self.extracted=!extracted
			else:
				$AnimationPlayer.play("zip")
				self.extracted=!extracted
