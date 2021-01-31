extends HBoxContainer

export(Array,Texture) onready var thoughtsTexture 


#list of thoughts
var thoughts:={
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

func update_textures(texture1:String,texture2=null,texture3=null):
	thoughtsTexture[0]=thoughts[texture1]
	if texture2==null : $TextureRect2.hide()  
	else: thoughtsTexture[1]=thoughts[texture2]
	if texture3==null : $TextureRect3.hide()  
	else: thoughtsTexture[2]=thoughts[texture3]

# Called when the node enters the scene tree for the first time.
func _ready():
	var children = get_children()
	var i:=0
	for child in children:
		if (children.size()>i):
			child.texture=thoughtsTexture[i]
			i+=1
