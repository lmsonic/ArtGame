extends Spatial

onready var sprite:AnimatedSprite3D=$AnimatedSprite3D

func _on_StaticBody_body_entered(body):
	if body is Player and Globals.has_doll:
		sprite.play("mad")
		get_tree().call_group("door","animate","2")
