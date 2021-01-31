extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var player :=get_parent().get_parent()



# Called when the node enters the scene tree for the first time.
func show_commands():
	$Commands.show()
	$Timer.start()


func _on_Timer_timeout():
	$Commands.hide()
	show()
