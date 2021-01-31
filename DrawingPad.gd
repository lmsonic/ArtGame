extends Spatial
onready var player:= $"../.."

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var extracted:=false setget set_extracted 
onready var draw=$GUIPanel3D/Viewport/Draw
func set_extracted(value:bool):
	extracted=value
	draw.extracted=value
	player.extracted=value
	player.get_node("AnimatedSprite3D").play("idle")
	print(extracted)
	




# Called when the node enters the scene tree for the first time.
func _input(event):
	if event.is_action_pressed("ui_select"):
		if not extracted:
			$AnimationPlayer.play("extract")
			self.extracted=!extracted
		else:
			$AnimationPlayer.play("zip")
			self.extracted=!extracted
