extends Sprite3D

#list of thoughts
var thoughts:={
	"exclamation": preload("res://assets/dialogue/thoughts/!.png"),
	"bone": preload("res://assets/dialogue/thoughts/bone.png"),
	"dollsign": preload("res://assets/dialogue/thoughts/dollisign.png"),
	"question": preload("res://assets/dialogue/thoughts/domand.png"),
	"eye2": preload("res://assets/dialogue/thoughts/eye2.png"),
	"eye": preload("res://assets/dialogue/thoughts/eye.png"),
	"face": preload("res://assets/dialogue/thoughts/face.png"),
	"hand": preload("res://assets/dialogue/thoughts/hand.png"),
	"hand2": preload("res://assets/dialogue/thoughts/hands2.png"),
	"happy": preload("res://assets/dialogue/thoughts/happ.png"),
	"key": preload("res://assets/dialogue/thoughts/key.png"),
	"mouth": preload("res://assets/dialogue/thoughts/mouth.png"),
	"sad": preload("res://assets/dialogue/thoughts/sad.png"),
	"whatsmissing": preload("res://assets/dialogue/thoughts/whastmissing.png"),
}

func _ready():
	$Thoughts.texture=thoughts["exclamation"]


func _on_Timer_timeout():
	#displays a random thought at timeout
	var rand = randi()%thoughts.keys().size()
	var i = 0
	for k in thoughts.keys():
		if i==rand:
			$Thoughts.texture=thoughts[k]
			return
		i+=1
