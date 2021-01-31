extends Node

var notebook_collected:=false setget show_commands

func show_commands(value):
	notebook_collected = value
	if value:
		get_tree().call_group("bubbles","show_commands")

var has_doll:=false
