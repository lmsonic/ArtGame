extends Sprite3D


var thoughts:={
	"exclamation": preload("res://assets/scrtte/!.png"),
	"bone": preload("res://assets/scrtte/bone.png"),
	"dollsign": preload("res://assets/scrtte/dollisign.png"),
	"question": preload("res://assets/scrtte/domand.png"),
	"eye2": preload("res://assets/scrtte/eye2.png"),
	"eye": preload("res://assets/scrtte/eye.png"),
	"face": preload("res://assets/scrtte/face.png"),
	"hand": preload("res://assets/scrtte/hand.png"),
	"hand2": preload("res://assets/scrtte/hands2.png"),
	"happy": preload("res://assets/scrtte/happ.png"),
	"key": preload("res://assets/scrtte/key.png"),
	"mouth": preload("res://assets/scrtte/mouth.png"),
	"sad": preload("res://assets/scrtte/sad.png"),
	"whatsmissing": preload("res://assets/scrtte/whastmissing.png"),
}

func _ready():
	$Thoughts.texture=thoughts["exclamation"]


func _on_Timer_timeout():
	var rand = randi()%thoughts.keys().size()
	var i = 0
	for k in thoughts.keys():
		if i==rand:
			$Thoughts.texture=thoughts[k]
			return
		i+=1
		
