extends Node


class_name Line

var start:Vector2
var end:Vector2
var width:float
var color:Color

func _init(start:Vector2,end:Vector2,width:float,color:Color):
	self.start=start
	self.end=end
	self.width=width
	self.color=color

func _to_json():
	return "{\"start\" : {\"x\":%f,\"y\":%f},\"end\": {\"x\":%f,\"y\":%f},\"width\" :%f,\"color\" : {\"r\":%f,\"g\":%f,\"b\":%f,\"a\":%f}}" % [start.x,start.y,end.x,end.y,width,color.r,color.g,color.b,color.a]

