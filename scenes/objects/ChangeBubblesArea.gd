extends Area

var previous_textures:Array = []

export (Array,String) var texture_strings:Array= ["question"]

func change_bubbles(body):
	if body is Player:
		var thought:Thought = get_tree().get_nodes_in_group("bubbleTextures")[0]
		var textures : Array = thought.get_textures()
		previous_textures =  textures if textures else []
		get_tree().call_group("bubbleTextures","update_textures",texture_strings)


func change_bubbles_on_exit(body):
	if body is Player:
		get_tree().call_group("bubbleTextures","update_textures",previous_textures)
