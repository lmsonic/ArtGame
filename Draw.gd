extends ColorRect

var points:PoolVector2Array=[]
var lines:=[]
var lastPos:=Vector2()
export(Color) var paintColor=Color.black
export(float) var paintWidth=1.0
var lineStarted:=false


func _ready():
	Input.set_use_accumulated_input(false)

func _input(event):
	if event.is_action_pressed("draw"):
		points.push_back(event.position)
		lineStarted=true
		update()
	if event.is_action("draw"):
		points.push_back(event.position)
		update()
	if event.is_action_released("draw"):
		points.push_back(event.position)
		lineStarted=false
		update()
		
	if lineStarted and event is InputEventMouseMotion:
		var line: = Line.new(event.position,
							event.position-event.relative,
							event.pressure*paintWidth,
							paintColor)
		lines.push_back(line)
		points.push_back(event.position)
		update()

func _draw():
	#draw_points(2.5,Color.black)
	draw_lines(lines,paintColor)
	
func draw_lines(lines,color:Color):
	for line in lines:
		draw_line(line.start,line.end,line.color,line.width,true)
	
func draw_points(width:float,color:Color):
	for point in points:
		draw_circle(point,width,color)
		
	

class Line:
	func _init(start,end,width,color):
		self.start=start
		self.end=end
		self.width=width
		self.color=color
	
	var start:Vector2
	var end:Vector2
	var width:float
	var color:Color
	
	
