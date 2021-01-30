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
		print(data.OriginalPoints[str(i)])
		i+=1
	i=0
	for line in gesture.Lines:
		data.Lines[str(i)]=line._to_json()
		print(data.Lines[str(i)])
		i+=1
	var file = File.new()
	print (data)
	file.open(gesture_path, File.WRITE)
	file.store_line(to_json(data))
	file.close()



static func load_gesture(name:String) ->Gesture :
	var file = File.new()
	if not file.file_exists(gesture_path):
		return null
		
	file.open(gesture_path, File.READ)
	var text = file.get_as_text()
	var data = parse_json(text)
	var originalGesturePoints :=[]
	var lines :=[]
	for i in range(0,data.OriginalPoints.size()):
		print(data.OriginalPoints[str(i)])
		var pointData= parse_json(data.OriginalPoints[str(i)])
		var point:Point = Point.new(pointData.X,pointData.Y,pointData.StrokeID)
		originalGesturePoints.push_back(point)		
	for i in range(0,data.Lines.size()):
		print(data.Lines[str(i)])
		var lineData= parse_json(data.Lines[str(i)])
		var start:Vector2= Vector2(lineData.start.x,lineData.start.y)
		var end:Vector2= Vector2(lineData.end.x,lineData.end.y)
		var color:Color= Color(lineData.color.r,lineData.color.g,lineData.color.b,lineData.color.a)
		var line:Line = Line.new(start,end,lineData.width,color)
		lines.push_back(line)
	
	var gesture = Gesture.new(originalGesturePoints,lines,data.Name)
	file.close()
	return gesture
