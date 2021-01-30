extends Control

var trainingSet:Array=[]
signal show_gesture
const gesture_folder = "user://gestures"
onready var textEdit := $MarginContainer/HBoxContainer/VBoxContainer/TextEdit


func _on_save():
	var name:String=textEdit.text
	if name!="":
		var points = get_parent().points
		var lines = get_parent().lines
		GestureIO.save_gesture(Gesture.new(points,lines,name))
	else:
		print("Name cannot be empty")

func _on_load():
	var name:String=textEdit.text
	if name!="":
		var gesture = GestureIO.load_gesture(name)
		if gesture:
			emit_signal('show_gesture',gesture)
		else:
			print("Could not find gesture")

