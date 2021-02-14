extends Node

class_name Point

var X:float
var Y:float
var StrokeID:int

func _init(x:float,y:float,strokeId:int):
	self.X = x;
	self.Y = y;
	self.StrokeID = strokeId;
	
func _to_json():
	return "{\"X\" : %d,\"Y\" : %d,\"StrokeID\" :%d}" % [self.X,self.Y,self.StrokeID]	

static func SqrEuclideanDistance(a:Point,b:Point)-> float:
	return (a.X - b.X) * (a.X - b.X) + (a.Y - b.Y) * (a.Y - b.Y);

static func EuclideanDistance(a:Point,b:Point) -> float:
	return sqrt(SqrEuclideanDistance(a, b));
