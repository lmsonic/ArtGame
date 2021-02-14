extends Spatial

onready var sprite:AnimatedSprite3D=$AnimatedSprite3D

func _on_StaticBody_body_entered(body):
	if body is Player and Globals.has_doll:
		sprite.play("mad")
		Globals.after_mad=true
		
