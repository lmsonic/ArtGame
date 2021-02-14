extends RichTextLabel


onready var timer :Timer=$Timer

func _ready():
	hide()


# Called when the node enters the scene tree for the first time.
func show_commands():
	show()
	timer.start()


func _on_Timer_timeout():
	hide()
	
