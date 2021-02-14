extends Node

var debug:=true

var notebook_collected:=false setget show_commands



func show_commands(value:bool):
	notebook_collected = value
	if value:
		get_tree().call_group("tutorial","show_commands")
		get_tree().call_group("bubbles","show_bubbles")

var has_doll:=false

var after_mad:=false setget change_after_mad

func change_after_mad(_value):
	get_tree().call_group("after_mad","animate")
	
func _process(delta):
	if debug:
		if Input.is_key_pressed(KEY_F1):
			self.notebook_collected = true
		if Input.is_key_pressed(KEY_F2):
			self.has_doll = true
		if Input.is_key_pressed(KEY_F3):
			self.after_mad = true

	

