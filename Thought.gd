extends Panel

export(Array,Texture) onready var thoughtsTexture 

# Called when the node enters the scene tree for the first time.
func _ready():
	$MarginContainer/TextureRect.texture=thoughtsTexture[0]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
