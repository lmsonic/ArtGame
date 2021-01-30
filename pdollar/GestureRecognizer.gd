extends Node

class_name PointCloudRecognizer

onready var Gesture :=preload("res://pdollar/Gesture.gd")
onready var Point :=preload("res://pdollar/Point.gd")
#/// <summary>
#/// Main function of the $P recognizer.
#/// Classifies a candidate gesture against a set of training samples.
#/// Returns the class of the closest neighbor in the training set.
#/// </summary>
#/// <param name="candidate"></param>
#/// <param name="trainingSet"></param>
#/// <returns></returns>
func Classify( candidate:Gesture,  trainingSet:Array) -> String:
	var minDistance:float = INF;
	var gestureClass := "";
	for template in trainingSet:
		var dist:float = GreedyCloudMatch(candidate.Points, template.Points);
		if dist < minDistance:
			minDistance = dist;
			gestureClass = template.Name;
	return gestureClass;

#/// <summary>
#/// Implements greedy search for a minimum-distance matching between two point clouds
#/// </summary>
#/// <param name="points1"></param>
#/// <param name="points2"></param>
#/// <returns></returns>
func GreedyCloudMatch(points1:Array,  points2:Array) -> float:
	var n:int = points1.size(); #// the two clouds should have 
								#the same number of points by now
	var eps:float = 0.5;       	#// controls the number of greedy 
								#search trials (eps is in [0..1])
	var step:int = int(floor(pow(n, 1.0 - eps)));
	var minDistance:float = INF;
	for i in range(0,n,step):
		var dist1:float = CloudDistance(points1, points2, i);   
		#// match points1 --> points2 starting with index point i
		var dist2:float = CloudDistance(points2, points1, i);   
		#// match points2 --> points1 starting with index point i
		minDistance = min(minDistance, min(dist1, dist2));
	return minDistance;

#/// <summary>
#/// Computes the distance between two point clouds by performing a minimum-distance greedy matching
#/// starting with point startIndex
#/// </summary>
#/// <param name="points1"></param>
#/// <param name="points2"></param>
#/// <param name="startIndex"></param>
#/// <returns></returns>
func CloudDistance(points1:Array,  points2:Array,  startIndex:int) -> float:
	var n:int = points1.size();      
	#// the two clouds should have the same number of points by now
	var matched := []; 
	#// matched[i] signals whether point i from the 2nd cloud has been already matched
	for i in range(n):
		matched[i]=false
	#// no points are matched at the beginning

	var sum:float = 0.0;  #// computes the sum of distances between matched points (i.e., the distance between the two clouds)
	var i:int = startIndex;
	while i != startIndex:
		var index :int = -1;
		var minDistance:float = INF;
		for j in range(n):
			if !matched[j]:
				var dist:float = Point.SqrEuclideanDistance(points1[i], points2[j]);
				#  // use squared Euclidean distance to save some processing time
				if dist < minDistance:
					minDistance = dist;
					index = j;
					
		matched[index] = true; 
		#// point index from the 2nd cloud is matched to point i from the 1st cloud
		var weight:float = 1.0 - ((i - startIndex + n) % n) / (1.0 * n);
		sum += weight * minDistance; 
		#// weight each distance with a confidence coefficient that decreases from 1 to 0
		i = (i + 1) % n;
	return sum;
