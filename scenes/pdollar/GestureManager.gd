extends Control

var trainingSet:Array=[]
signal show_gesture
signal clear
signal recognized(shape)
onready var textEdit := $MarginContainer/HBoxContainer/VBoxContainer/TextEdit
onready var textLabel:=$MarginContainer/HBoxContainer/VBoxContainer/Label
export var threshold:= 0.6

func update_gestures():
	trainingSet=GestureIO.load_gestures()

func _ready():
	trainingSet=GestureIO.load_gestures()
	get_tree().call_group("recognized","connect_signal",self)
	
func recognize():
	var points = get_parent().points
	if points and points.size()>8:
		var result = GestureRecognizer.Classify(Gesture.new(points,[],""),trainingSet)
		textLabel.text = result.GestureClass+' '+ str(result.Score)
		emit_signal("clear")
		if result.Score>threshold:
			emit_signal("recognized",result.GestureClass)
		

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
