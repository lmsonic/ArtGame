extends Node

class_name Recognized

export(String)var shape ="triangle"

#this gets called by the drawing recognizer on all elements of the group
# "recognized"
func connect_signal(node:Node):
	node.connect("recognized",self,"triggered")

#this gets called whenever the signal "recognized" is called, can be overridden
func triggered(result):
	if result==shape:
		print("Triggerato "+self.name)

