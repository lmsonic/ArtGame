extends Spatial

class_name Recognized

export(String)var shape ="triangle"
export(float)var distanceToTrigger =5.0
onready var player = get_tree().root.get_child(0).get_node("Player")
#this gets called by the drawing recognizer on all elements of the group
# "recognized"
func connect_signal(node:Node):
	node.connect("recognized",self,"triggered")

#this gets called whenever the signal "recognized" is called, can be overridden
func triggered(result):
	if result==shape:
		print("Triggerato "+self.name)

