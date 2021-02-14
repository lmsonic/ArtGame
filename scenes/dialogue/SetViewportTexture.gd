extends Sprite3D


func _ready():
	texture = ($Viewport as Viewport).get_texture()
