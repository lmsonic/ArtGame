extends Node

class_name Recognized
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#onready var path = get_tree().root.get_child(0).get_node("Cubio/Camera/GUIPanel3D/Viewport/Draw/GUIRecognizer")
export(String)var shape ="triangle"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass#path.connect("recognised",self,"triggered")

func connect_signal(node:Node):
	node.connect("recognized",self,"triggered")

func triggered(result):
	if result==shape:
		print("Triggerato "+self.name)

