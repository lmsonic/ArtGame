extends Panel

export(Array,Texture) onready var thoughtsTexture 

# Called when the node enters the scene tree for the first time.
func _ready():
	var children = $MarginContainer/HBoxContainer.get_children()
	var i:=0
	for child in children:
		if (children.size()>i):
			child.texture=thoughtsTexture[i]
			i+=1

