extends Node

class_name Gesture
#	/// <summary>
#    /// Implements a gesture as a cloud of points (i.e., an unordered set of points).
#    /// Gestures are normalized with respect to scale, translated to origin, and resampled into a fixed number of 32 points.
#    /// </summary>
onready var Point:=preload("res://pdollar/Point.gd")
var Points:Array           #// gesture points (normalized)
var Name: = "";                 #// gesture class
const SAMPLING_RESOLUTION := 32;
#/// <summary>
#/// Constructs a gesture from an array of points
#/// </summary>
#/// <param name="points"></param>
func _init(points:Array, gestureName:String = ""):
	self.Name = gestureName;
	#// normalizes the array of points with respect to scale, origin, 
	#and number of points
	self.Points = Scale(points);
	self.Points = TranslateTo(Points, Centroid(Points));
	self.Points = Resample(Points, SAMPLING_RESOLUTION);
#/// <summary>
#/// Performs scale normalization with shape preservation into [0..1]x[0..1]
#/// </summary>
#/// <param name="points"></param>
#/// <returns></returns>
func Scale(points:Array)-> Array:
	var minx:float = INF
	var miny:float = INF
	var maxx:float = -INF
	var maxy:float = -INF
	for i in range(points.size()):
		if minx > points[i].X :minx = points[i].X;
		if miny > points[i].Y :miny = points[i].Y;
		if maxx < points[i].X :maxx = points[i].X;
		if maxy < points[i].Y :maxy = points[i].Y;
	
	var newPoints: = []
	var scale:float = max(maxx - minx, maxy - miny);
	for i in range(points.size()):
		newPoints[i] = Point.new((points[i].X - minx) / scale, 
						(points[i].Y - miny) / scale, 
						points[i].StrokeID);
	return newPoints;
#/// <summary>
#/// Translates the array of points by p
#/// </summary>
#/// <param name="points"></param>
#/// <param name="p"></param>
#/// <returns></returns>
func TranslateTo(points:Array, p:Point) -> Array:
	var newPoints: = []
	for i in range(points.size()):
		newPoints[i] = Point.new(points[i].X - p.X, 
					points[i].Y - p.Y, 
					points[i].StrokeID);
	return newPoints;
#/// <summary>
#/// Computes the centroid for an array of points
#/// </summary>
#/// <param name="points"></param>
#/// <returns></returns>
func Centroid(points:Array) -> Point:
	var cx:float = 0.0
	var cy:float = 0.0
	for i in range(points.size()):
		cx += points[i].X;
		cy += points[i].Y;
	return Point.new(cx / points.size(), cy / points.size(), 0);
#/// <summary>
#/// Resamples the array of points into n equally-distanced points
#/// </summary>
#/// <param name="points"></param>
#/// <param name="n"></param>
#/// <returns></returns>
func Resample(points:Array,  n:int) -> Array:
	var newPoints: = []
	newPoints[0] = Point.new(points[0].X, points[0].Y, points[0].StrokeID);
	var numPoints:= 1;

	var I:float = PathLength(points) / (n - 1); #// computes interval length
	var D:float = 0.0;
	for i in range(points.size()):
		if points[i].StrokeID == points[i - 1].StrokeID:
			var d:float = Point.EuclideanDistance(points[i - 1], points[i]);
			if D + d >= I:
				var firstPoint:Point = points[i - 1];
				while D + d >= I:
					#// add interpolated point
					var t:float = min(max((I - D) / d, 0.0), 1.0);
					if t==NAN: t = 0.5
					newPoints[numPoints] = Point.new(
						(1.0 - t) * firstPoint.X + t * points[i].X,
						(1.0 - t) * firstPoint.Y + t * points[i].Y,
						points[i].StrokeID)
					numPoints+=1
					#// update partial length
					d = D + d - I;
					D = 0;
					firstPoint = newPoints[numPoints - 1];
				D = d;
			else: D += d;

	if numPoints == n - 1: #// sometimes we fall a rounding-error short of adding the last point, so add it if so
		newPoints[numPoints] = Point.new(points[points.size() - 1].X, 
						points[points.size() - 1].Y, 
						points[points.size() - 1].StrokeID);
		numPoints+=1
	return newPoints;

#/// <summary>
#/// Computes the path length for an array of points
#/// </summary>
#/// <param name="points"></param>
#/// <returns></returns>
func PathLength(points:Array) -> float:
	var length:float = 0.0;
	for i in range(points.size()):
		if points[i].StrokeID == points[i - 1].StrokeID:
			length += Point.EuclideanDistance(points[i - 1], points[i]);
	return length;

