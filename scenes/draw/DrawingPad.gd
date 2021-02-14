extends Spatial
onready var player:Player= $"../.."

var extracted:=false setget set_extracted

onready var draw:Draw=$GUIPanel3D/Viewport/Draw
onready var anim:AnimationPlayer=$AnimationPlayer

#when the drawing is extracted/zipped, the player stops, the drawing stops
func set_extracted(value:bool):
	if Globals.notebook_collected:
		extracted=value
		draw.extracted=value
		player.extracted=value
		player.set_animation("idle")
	#print(extracted)
	

#extacts/zips the drawing
func _input(event:InputEvent):
	if event.is_action_pressed("open_notebook"):
		if Globals.notebook_collected:
			if not extracted:
				anim.play("extract")
				self.extracted=!extracted
			else:
				anim.play("zip")
				self.extracted=!extracted
