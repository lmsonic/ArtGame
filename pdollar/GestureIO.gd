extends Node

class_name GestureIO

const gesture_path = "user://gestures.json"
const default_data :Dictionary = {
	'Name' : 'Gesture',
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
	var file = File.new()
	
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
	for i in range(0,data.OriginalPoints.size()):
		print(data.OriginalPoints[str(i)])
		var pointData= parse_json(data.OriginalPoints[str(i)])
		var point:Point = Point.new(pointData["X"],pointData["Y"],pointData["StrokeID"])
		originalGesturePoints.push_back(point)
	
	var gesture = Gesture.new(originalGesturePoints,data.Name)
	file.close()
	return gesture


