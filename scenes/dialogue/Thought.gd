extends MarginContainer

export(Array,Texture) var thoughtsTexture : Array

onready var grid:GridContainer=$VBoxContainer/GridBoxContainer
onready var hbox:HBoxContainer=$VBoxContainer/HBoxContainer

#list of thoughts
onready var thoughts:={
	"exclamation": preload("res://assets/dialogue/thoughts/!.png"),
	"bone": preload("res://assets/dialogue/thoughts/bone.png"),
	"dollsign": preload("res://assets/dialogue/thoughts/dollisign.png"),
	"question": preload("res://assets/dialogue/thoughts/domand.png"),
	"eye2": preload("res://assets/dialogue/thoughts/eye2.png"),
	"eye": preload("res://assets/dialogue/thoughts/eye.png"),
	"face": preload("res://assets/dialogue/thoughts/face.png"),
	"hand": preload("res://assets/dialogue/thoughts/hand.png"),
	"hand2": preload("res://assets/dialogue/thoughts/hands2.png"),
	"happy": preload("res://assets/dialogue/thoughts/happ.png"),
	"key": preload("res://assets/dialogue/thoughts/key.png"),
	"mouth": preload("res://assets/dialogue/thoughts/mouth.png"),
	"sad": preload("res://assets/dialogue/thoughts/sad.png"),
	"whatsmissing": preload("res://assets/dialogue/thoughts/whastmissing.png"),
}

func update_textures(textures:Array):
	thoughtsTexture = []
	for i in range(textures.size()):
		thoughtsTexture.push_back(thoughts[textures[i]])
	
	delete_children(grid)
	delete_children(hbox)
	add_children()
	
func _ready():
	add_children()

static func delete_children(node:Node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()

# Called when the node enters the scene tree for the first time.
func add_children():
	hbox.hide()
	grid.hide()
	for i in thoughtsTexture.size():
		var rect:TextureRect=TextureRect.new()
		rect.texture = thoughtsTexture[i]
		rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		rect.size_flags_horizontal = TextureRect.SIZE_EXPAND_FILL
		rect.size_flags_vertical = TextureRect.SIZE_EXPAND_FILL
		if thoughtsTexture.size()%2==1 and i==thoughtsTexture.size()-1:
			hbox.show()
			hbox.add_child(rect)
		else:
			if !grid.visible: grid.show()
			grid.add_child(rect)
				
		

