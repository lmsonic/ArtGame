extends ColorRect

var points:=[]
var lines:=[]
export(Color) var paintColor=Color.black
export(float) var paintWidth=1.0
var lineStarted:=false
var strokeId:=-1

onready var labelText := $GUIRecognizer/MarginContainer/HBoxContainer/VBoxContainer/Label

var extracted:=true  setget set_extracted

#when the drawing is extracted/zipped, the viewport stops
func set_extracted(value:bool):
	extracted=value

#extra precision
func _ready():
	Input.set_use_accumulated_input(false)

	
func reset():
	points.resize(0)
	lines.clear()
	lineStarted=false
	#labelText.text="Gesture"
	update()

func _input(event):
	if extracted:
		if event.is_action_pressed("draw"):
			#starts a stroke
			strokeId+=1
			points.push_back(Point.new(event.position.x,event.position.y,strokeId))
			lineStarted=true
			update()
		if event.is_action("draw"):
			#continues a stroke
			points.push_back(Point.new(event.position.x,event.position.y,strokeId))
			update()
		if event.is_action_released("draw"):
			#finishes a stroke
			points.push_back(Point.new(event.position.x,event.position.y,strokeId))
			$GUIRecognizer/Timer.start()
			lineStarted=false
			update()
			
		if lineStarted and event is InputEventMouseMotion:
			#draws line
			var line: = Line.new(event.position,
								event.position-event.relative,
								event.pressure*paintWidth,
								paintColor)
			lines.push_back(line)
			points.push_back(Point.new(event.position.x,event.position.y,strokeId))
			update()

func _draw():
	#draw_points(2.5,Color.black)
	if extracted:
		draw_lines(lines)
	
func draw_lines(lines):
	for line in lines:
		draw_line(line.start,line.end,line.color,line.width,true)
	
func draw_points(width:float,color:Color):
	for point in points:
		var v:Vector2 = Vector2(point.X,point.Y)
		draw_circle(v,width,color)
		
	

func _on_show_gesture(gesture:Gesture):
	#displays gesture
	reset()
	points=gesture.OriginalPoints
	lines=gesture.Lines
	update()