extends Spatial

class_name Recognized

export(String)var shape :="triangle"
export(float)var distanceToTrigger :=15
onready var player :Player
#this gets called by the drawing recognizer on all elements of the group
# "recognized"
func _init():
	add_to_group("knows_player")
	add_to_group("recognized")
	
	
func set_player(node:Player):
	player=node

func connect_signal(node:Node):
	node.connect("recognized",self,"triggered")

#this gets called whenever the signal "recognized" is called, can be overridden
func triggered(result:String):
	if result==shape:
		print("Triggerato "+self.name)

