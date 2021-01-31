extends Sprite3D


 time.
func _ready():


func _on_Area_body_entered(body):
	if body is Player:
		Globals.notebook_collected=true
		queue_free()
