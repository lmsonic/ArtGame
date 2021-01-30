extends Control

var trainingSet:Array=[]
signal show_gesture
signal clear
const gesture_folder = "user://gestures"
onready var textEdit := $MarginContainer/HBoxContainer/VBoxContainer/TextEdit
onready var textLabel:=$MarginContainer/HBoxContainer/VBoxContainer/Label
func update_gestures():
	trainingSet=GestureIO.load_gestures()

func _ready():
	trainingSet=GestureIO.load_gestures()
	
func recognize():
	var points = get_parent().points
	if points:
		var result = GestureRecognizer.Classify(Gesture.new(points,[],""),trainingSet)
		textLabel.text = result.GestureClass+' '+ str(result.Score)

func _on_save():
	var name:String=textEdit.text
	if name!="":
		var points = get_parent().points
		var lines = get_parent().lines
		GestureIO.save_gesture(Gesture.new(points,lines,name))
		textEdit.text=""
		emit_signal("clear")
		update_gestures()
	else:
		print("Name cannot be empty")
	
	

func _on_load():
	var name:String=textEdit.text
	if name!="":
		var gesture = GestureIO.load_gesture(name)
		if gesture:
			emit_signal('show_gesture',gesture)
			textEdit.text=""
		else:
			print("Could not find gesture")



func _on_DeleteGestures_button_down():
	GestureIO.delete_gestures()
