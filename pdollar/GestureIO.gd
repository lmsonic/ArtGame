extends Node

class_name GestureIO

const gesture_path = "user://gestures.json"
const default_data :Dictionary = {
	'Name' : 'Gesture',
	'Lines': {
		
	},
	'OriginalPoints' : {
		
	}
}

# Called when the node enters the scene tree for the first time.
static func save_gesture(gesture:Gesture):
	var data :Dictionary = default_data
	data.Name=gesture.Name
	var i:=0
	for point in gesture.OriginalPoints:
		data.OriginalPoints[str(i)]=point._to_json()
		i+=1
	i=0
	for line in gesture.Lines:
		data.Lines[str(i)]=line._to_json()
		i+=1
		
	var dict := {data.Name: to_json(data)}
	var file = File.new()
		
	if file.file_exists(gesture_path):
		file.open(gesture_path, File.READ)
		var f = parse_json(file.get_as_text())
		file.close()
		f[data.Name]=dict[data.Name]
		file.open(gesture_path, File.WRITE)
		file.store_line(to_json(f))
	else:
		file.open(gesture_path, File.WRITE)
		file.store_line(to_json(dict))
		
	
	file.close()
	



static func load_gesture(gestureName:String) ->Gesture :
	var file = File.new()
	if not file.file_exists(gesture_path):
		return null
		
	file.open(gesture_path, File.READ)
	var text = file.get_as_text()
	file.close()
	var data = parse_json(text)
	var gestureData = parse_json(data[gestureName])
	var originalGesturePoints :=[]
	var lines :=[]
	for i in range(0,gestureData.OriginalPoints.size()):
		var pointData= parse_json(gestureData.OriginalPoints[str(i)])
		var point:Point = Point.new(pointData.X,pointData.Y,pointData.StrokeID)
		originalGesturePoints.push_back(point)		
	for i in range(0,gestureData.Lines.size()):
		var lineData= parse_json(gestureData.Lines[str(i)])
		var start:Vector2= Vector2(lineData.start.x,lineData.start.y)
		var end:Vector2= Vector2(lineData.end.x,lineData.end.y)
		var color:Color= Color(lineData.color.r,lineData.color.g,lineData.color.b,lineData.color.a)
		var line:Line = Line.new(start,end,lineData.width,color)
		lines.push_back(line)
	
	var gesture = Gesture.new(originalGesturePoints,lines,gestureName)
	
	return gesture
	
static func load_gestures() -> Array :
	var file = File.new()
	if not file.file_exists(gesture_path):
		return []
		
	file.open(gesture_path, File.READ)
	var text = file.get_as_text()
	file.close()
	var data :Dictionary= parse_json(text)
	var gestures:=[]
	for k in data.keys():
		var gestureData = parse_json(data[k])
		var originalGesturePoints :=[]
		var lines :=[]
		for i in range(0,gestureData.OriginalPoints.size()):
			var pointData= parse_json(gestureData.OriginalPoints[str(i)])
			var point:Point = Point.new(pointData.X,pointData.Y,pointData.StrokeID)
			originalGesturePoints.push_back(point)		
		for i in range(0,gestureData.Lines.size()):
			var lineData= parse_json(gestureData.Lines[str(i)])
			var start:Vector2= Vector2(lineData.start.x,lineData.start.y)
			var end:Vector2= Vector2(lineData.end.x,lineData.end.y)
			var color:Color= Color(lineData.color.r,lineData.color.g,lineData.color.b,lineData.color.a)
			var line:Line = Line.new(start,end,lineData.width,color)
			lines.push_back(line)
		
		var gesture = Gesture.new(originalGesturePoints,lines,k)
		gestures.push_back(gesture)
	return gestures
