extends Control

var change:=false

func _on_Timer_timeout():
	if not change:
		($TextureRect as TextureRect).hide()
		($TextureRect2 as TextureRect).show()
		($Timer as Timer).start()
		change=true
	else:
		get_tree().change_scene("res://scenes/main/Main.tscn")
