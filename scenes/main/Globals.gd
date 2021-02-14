extends Node

var notebook_collected:=false setget show_commands

func show_commands(value:bool):
	notebook_collected = value
	if value:
		get_tree().call_group("tutorial","show_commands")
		get_tree().call_group("bubbles","show_bubbles")

var has_doll:=false

