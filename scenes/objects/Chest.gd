extends "res://scenes/objects/Recognized.gd"

var opened:=false
var red:=false

onready var doll :AnimatedSprite3D=$Doll
onready var anim :AnimationPlayer=$AnimationPlayer

func _ready():
	doll.hide()

func triggered(result:String):
	if player:
		var dist :float = (self.transform.origin-player.transform.origin).length()
		if dist<distanceToTrigger:
			if result=="hand" and opened:
				doll.play("red")
				red=true
			if result=="key":
				doll.show()
				anim.play("open")
				get_parent().play("open")
				opened=true

func _on_Area_body_entered(body):
	if body is Player and red:
		Globals.has_doll=true
		queue_free()



