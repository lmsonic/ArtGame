extends MeshInstance

func _ready():
	var mat:Material = get_surface_material(0)
	mat.albedo_texture = ($"../Viewport" as Viewport).get_texture()
	set_surface_material(0,mat)
