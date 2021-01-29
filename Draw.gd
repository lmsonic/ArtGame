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
		lines.push_back([event.position,event.position-event.relative])
		points.push_back(event.position)
		update()

func _draw():
	#draw_points(2.5,Color.black)
	draw_lines(lines,paintWidth,paintColor)
	
func draw_lines(lines,width:float,color:Color):
	for line in lines:
		draw_line(line[0],line[1],color,width)
	
func draw_points(width:float,color:Color):
	for point in points:
		draw_circle(point,width,color)
		
	
	
	
	
	
